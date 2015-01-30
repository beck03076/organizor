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

      if self_name != "Programme"
        # recording impressions and retrieving them
        is_impressionable :counter_cache => true, :unique => :request_hash
        #setting assigned_at value
        before_save :set_assigned_at     
      end      

      #========= Actions on Core Start ============
      has_many :follow_ups, as: :follow_upable
      has_many :tasks,as: :taskable
      has_many :notes,as: :noteable
      has_and_belongs_to_many :emails, :uniq => true
      #============================================

      #core model has the followin actions so attr accesible is must for Form, fields_for
      attr_accessible :emails_attributes,:follow_ups_attributes,:notes_attributes,:tasks_attributes,
                      :emails_count, :follow_ups_count, :tasks_count, :notes_count,:impressions_count

      #core model has the followin actions so accepting nested attributes is must for Form, fields_for 
      accepts_nested_attributes_for :emails,:follow_ups,:notes,:tasks, :allow_destroy => true                 
      
      
      self_pl = self_name.downcase.pluralize
      self_id = (self.name.downcase + "_id")
      
      scope :todays, includes(:follow_ups).where("date(follow_ups.starts_at) = '#{Date.today.to_s(:db)}'")
                               
      scope :this_weeks, includes(:follow_ups).where("date(follow_ups.starts_at) BETWEEN '#{Date.today.at_beginning_of_week.to_s(:db)}' AND '#{Date.today.at_end_of_week.to_s(:db)}'")
                                   
      scope :this_months, includes(:follow_ups).where("date(follow_ups.starts_at) BETWEEN '#{Date.today.at_beginning_of_month.to_s(:db)}' AND '#{Date.today.at_end_of_month.to_s(:db)}'")

      scope :no_follow_ups, includes(:follow_ups).where("follow_ups.follow_upable_id IS NULL")

    end

  end
  
  # ===========
  # = Methods =
  # ===========



  def set_assigned_at
    return if !assigned_to_changed?
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
    emails_count + notes_count + tasks_count + follow_ups_count
  end
  
  # =================
  # = Class Methods =
  # =================
  module ClassMethods    
       def ignore(*x)
         scoped
       end
  end  
end
