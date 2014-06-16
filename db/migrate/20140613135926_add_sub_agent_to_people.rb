class AddSubAgentToPeople < ActiveRecord::Migration
  def change
    add_column :people, :sub_agent, :boolean
  end
end
