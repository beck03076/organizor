class FixEmail1Email2Enquiries < ActiveRecord::Migration
  def up
   rename_column :enquiries, :email1, :email
   rename_column :enquiries, :email2, :alternate_email
  end

  def down
   rename_column :enquiries, :email, :email1
   rename_column :enquiries, :alternate_email, :email2
  end
end
