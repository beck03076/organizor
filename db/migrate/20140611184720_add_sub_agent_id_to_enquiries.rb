class AddSubAgentIdToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :sub_agent_id, :integer
  end
end
