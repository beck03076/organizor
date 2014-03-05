module FetchFromContract
  # ===========
  # = Methods =
  # ===========
  def fetch_from_contract(prog_id)
    # p for programme, i for institution and r_ids for registration_ids, r for registration
    p = Programme.find(prog_id)
    i = p.institution
    r = p.registration
    # how manieth registration is this for this institution is r_order
    r_order = self.r_order(r.id,i.id)
        # ss stands for sliding scales, assuming only one contract per institution    
        ss = i.contracts.first.sliding_scales
        # case where there is no sliding scale at all
        if ss.nil?
          @out = "No Sliding Scale Configured!"
        elsif !ss.nil? 
          # case where there is sliding scale but without course_levels
          if (ss.map &:course_level_name).flatten.blank?          
            range_array = ss.sliding_ranges.map{|i| [i.from,i.to,i.commission_percentage] }
            # this prepares from nil situations(50+) and checks if the r_order is in between a range and sets the right percentage
            self.check_range(range_array,r_order)
            #set follow_up for progression
            self.set_reg_fu(ss,p,r,i)
          # case where there is sliding scale but with course_levels
          else
            # creating an array with ss object and course_level arrays like [obj1,["ug,"pg"],obj2,["phd"]]
            ss_cls = ss.map {|i| [i,i.course_level_name]}
            # checking if the programmes course_level_name exists in any of the 2nd elem in prev arr
            final_ss = ss_cls.map {|s| s[1].include?(p.course_level_name) ? s[0] : nil }.compact.first
            if final_ss.nil?
                @out = "Sliding Scale not configured for this course level!"
            else
                # fetching the sliding_ranges for the selected sliding_scale
                range_array = final_ss.sliding_ranges.map{|i| [i.from,i.to,i.commission_percentage] }  
                self.check_range(range_array,r_order)
                 #set follow_up for progression
                self.set_reg_fu(final_ss,p,r,i)
            end
          end
        end
    @out
  end
  
  def r_order(r_id,i_id)
    # ordering based on the sequence of the ref_no
    r_arr = Programme.joined_ins(i_id).order(:ins_ref_no).map &:registration_id
    p "#######" 
    p r_arr
    p r_id
    (r_arr.index(r_id) + 1)
  end
  
  def set_reg_fu(ss,p,r,i)    

    [["second_year",1],["third_year",2]].each do |y|
       tit = "#{r.ref_no} #{y[0].titleize} FollowUp"
       comm = ss.send(y[0])
       ass_to = current_user.conf.def_progression_fu_ass_to
      if comm && FollowUp.where(title: tit,assigned_to: ass_to).blank?
       tit = "#{r.ref_no} #{y[0].titleize} FollowUp"
       s_at = (p.start_date + y[1].year)
       r_bef = s_at - 5.days
       e_at = s_at + 15.days
       de = "#{r.name}[#{r.ref_no}] is about to progress, #{i.name} has agreed to pay #{comm}% commission for #{y[0].titleize}. Please follow this up."
    
        FollowUp.create!(title: tit,
                         desc: de,
                         starts_at: s_at,
                         remind_before: r_bef,
                         ends_at: e_at,
                         assigned_to: ass_to,
                         assigned_by: current_user.id,
                         registration_id: r.id)
      end
    end
  end

  def check_range(range_arr,order)
    clean_range_arr = self.from_plus(range_arr)
    clean_range_arr.each do |i|
      if order.between?((i[0] - 1),i[1])
       @out = i[2]
       break
      end
    end
    @out = @out.blank? ? "Not in(Over/Below) Student Range" : @out
  end
  
  def from_plus(arr)
    final = []
    arr.each do |i|
      if !i[1].nil?
        if i[0].nil?
          final << [i[1],1000000,i[2]]
        else
          final << i
        end  
      end
    end
    final
  end
 
  
end