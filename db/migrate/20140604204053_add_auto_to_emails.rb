class AddAutoToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :auto, :boolean
  end
end
