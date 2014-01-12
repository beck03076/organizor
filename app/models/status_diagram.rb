class StatusDiagram < ActiveRecord::Base
  attr_accessible :programme_id, :status_id, :user_id
  belongs_to :programme
  belongs_to :application_status, foreign_key: "status_id"
  belongs_to :user
end
