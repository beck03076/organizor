class CreateSubAgents < ActiveRecord::Migration
  def change
    create_table :sub_agents do |t|
      t.string :name
      t.text :desc
      t.integer :contact_id
      
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
