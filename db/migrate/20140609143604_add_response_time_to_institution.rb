class AddResponseTimeToInstitution < ActiveRecord::Migration
  def change
    add_column :institutions, :response_time, :string
  end
end
