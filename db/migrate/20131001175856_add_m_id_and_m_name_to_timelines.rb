class AddMIdAndMNameToTimelines < ActiveRecord::Migration
  def change
    add_column :timelines, :m_id, :integer
    add_column :timelines, :m_name, :string
  end
end
