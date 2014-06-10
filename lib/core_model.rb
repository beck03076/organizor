module CoreModel
  
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

      if !self_name == "Programme"
        # recording impressions and retrieving them
        is_impressionable :counter_cache => true, :unique => :request_hash
        #setting assigned_at value
        before_create :set_assigned_at     
      end      

      #========= Actions on Core Start ============
      has_many :follow_ups, as: :follow_upable
      has_many :todos,as: :todoable
      has_many :notes,as: :noteable
      has_and_belongs_to_many :emails, :uniq => true
      #============================================

      #core model has the followin actions so attr accesible is must for Form, fields_for
      attr_accessible :emails_attributes,:follow_ups_attributes,:notes_attributes,:todos_attributes,
                      :emails_count, :follow_ups_count, :todos_count, :notes_count

      #core model has the followin actions so accepting nested attributes is must for Form, fields_for 
      accepts_nested_attributes_for :emails,:follow_ups,:notes,:todos, :allow_destroy => true                 
      
      
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

  def set_assigned_at
    return of
    self.assigned_at = Time.now
  end
  
  def f_ups
        self.follow_ups.map{|i| i.starts_at.to_s }
  end
    
  def follow_up_date
        out = self.follow_ups.map{|i| dat(i.starts_at) }.sort
        out.size > 1 ? out[0] + "<span title='#{out.join(", ")}' class=tooltip-c>...</span>".html_safe : out[0]
  end

  def total_score
    emails_count + notes_count + todos_count + follow_ups_count
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
         scoped
       end
  end  
end
