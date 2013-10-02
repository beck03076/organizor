class AddCommentToTimelines < ActiveRecord::Migration
  def change
    add_column :timelines, :comment, :text
  end
end
