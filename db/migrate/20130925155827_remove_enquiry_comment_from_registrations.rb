class RemoveEnquiryCommentFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :enquiry_comment
  end

  def down
    add_column :registrations, :enquiry_comment, :text
  end
end
