class AddEnquiryCommentToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :enquiry_comment, :text
  end
end
