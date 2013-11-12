module ScopeExtension
  module FollowUpScopes
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
       scope :todays, where("enquiries.id IN (SELECT fu.enquiry_id FROM follow_ups fu 
                               WHERE date(fu.starts_at) = '#{Date.today}')")
                               
      scope :this_weeks, where("enquiries.id IN (SELECT fu.enquiry_id FROM follow_ups fu 
                                   WHERE date(fu.starts_at) BETWEEN '#{Date.today.at_beginning_of_week}' AND '#{Date.today.at_end_of_week}')")
                                   
      scope :this_months, where("enquiries.id IN (SELECT fu.enquiry_id FROM follow_ups fu 
                                   WHERE date(fu.starts_at) BETWEEN '#{Date.today.at_beginning_of_month}' AND '#{Date.today.at_end_of_month}')")
    end
  end
end

ActiveRecord::Base.send(:include, ScopeExtension)
