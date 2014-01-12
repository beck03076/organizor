class TodoTopic < ActiveRecord::Base
  has_many :todos, class_name: "Todo", foreign_key: "topic_id"
  attr_accessible :desc, :name
  
  
  def user_todos(u_id)
    self.todos.where(assigned_to: u_id)
  end
end
