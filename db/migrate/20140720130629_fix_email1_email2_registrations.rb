class FixEmail1Email2Registrations < ActiveRecord::Migration
  def up
   rename_column :registrations, :email1, :email
   rename_column :registrations, :email2, :alternate_email
  end

  def down
   rename_column :registrations, :email, :email1
   rename_column :registrations, :alternate_email, :email2
  end
end
