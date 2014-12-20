class AddRegistrationIdToQualifications < ActiveRecord::Migration
  def change
    add_column :qualifications, :registration_id, :integer
  end
end
