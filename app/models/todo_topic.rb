class TodoTopic < ActiveRecord::Base
  has_many :todos
  attr_accessible :desc, :name
end
