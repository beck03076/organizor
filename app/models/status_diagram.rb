class StatusDiagram < ActiveRecord::Base
  attr_accessible :programme_id, :status_id, :user_id
  belongs_to :programme
  belongs_to :application_status, foreign_key: "status_id"
  belongs_to :user
  
  def status_name
    self.application_status.name rescue "Unknown"
  end
  
  def user_name
    self.user.first_name rescue "Unknown"
  end
end
