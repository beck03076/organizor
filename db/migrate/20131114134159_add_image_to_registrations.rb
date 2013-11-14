class AddImageToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :image, :string
  end
end
