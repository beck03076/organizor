module CoreExtension
  
  # ============
  # = Included =
  # ============
  def self.included(base)
    base.extend(ClassMethods)
    
    # ===========
    # = Scoping =
    # ===========
   # base.scope :pending, base.where(:time_of_trade.exists => true)
   
    base.class_eval do
      # setting variable names to be used in the current class
      self_name = self.name
      self_pl = self_name.downcase.pluralize
      self_id = (self.name.downcase + "_id")
      
      scope :todays, where("#{self_pl}.id IN (SELECT fu.#{self_id} FROM follow_ups fu 
                               WHERE date(fu.starts_at) = '#{Date.today.to_s(:db)}')")
                               
      scope :this_weeks, where("#{self_pl}.id IN (SELECT fu.#{self_id} FROM follow_ups fu 
                                   WHERE fu.starts_at BETWEEN '#{Date.today.at_beginning_of_week.to_s(:db)}' AND '#{Date.today.at_end_of_week.to_s(:db)}')")
                                   
      scope :this_months, where("#{self_pl}.id IN (SELECT fu.#{self_id} FROM follow_ups fu 
                                   WHERE date(fu.starts_at) BETWEEN '#{Date.today.at_beginning_of_month.to_s(:db)}' AND '#{Date.today.at_end_of_month.to_s(:db)}')")
    end

  end
  
  # ===========
  # = Methods =
  # ===========
  
  def f_ups
        self.follow_ups.map{|i| i.starts_at.to_s }
  end
    
  def follow_up_date
        out = self.follow_ups.map{|i| dat(i.starts_at) }.sort
        out.size > 1 ? out[0] + "<span title='#{out.join(", ")}' class=tooltip-c>...</span>".html_safe : out[0]
  end
  
  # =================
  # = Class Methods =
  # =================
  module ClassMethods    
       def no_followups
            self_id = (self.name.downcase + "_id").to_sym
            includes(:follow_ups).where( :follow_ups => { self_id => nil} )
       end
       
       def ignore(*x)
         self
       end
  end
  
  
  
  
end
