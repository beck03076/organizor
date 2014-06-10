class AddCoreToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :core, :string
  end
end
