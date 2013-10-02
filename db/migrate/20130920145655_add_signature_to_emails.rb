class AddSignatureToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :signature, :text
  end
end
