class AddIndexToForeignKeys < ActiveRecord::Migration
  def change
    [:assigned_to,:assigned_by,:created_by,:updated_by,:country_id,:status_id,:contact_type_id,:branch_id,:registered_by,
     :student_source_id,:sub_agent_id].each do |i|
       add_index :enquiries, i
    end
  end
end
