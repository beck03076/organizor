class AddResponseTimeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :response_time, :string
  end
end
