class AddIndexToForeignKeysRegistrations < ActiveRecord::Migration
  def change
  	  [:contact_type_id,:branch_id,:student_source_id,:sub_agent_id,:enquiry_id,:progression_status_id,:qualification_id].each do |i|
         add_index :registrations,i
      end    
  end
end
