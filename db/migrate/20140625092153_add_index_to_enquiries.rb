class AddIndexToEnquiries < ActiveRecord::Migration
  def change
      [:contact_type_id,:branch_id,:student_source_id,:sub_agent_id,:status_id,:registered_by].each do |i|
         add_index :enquiries,i
      end
  end
end
