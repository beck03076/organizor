class AddDescToSmtps < ActiveRecord::Migration
  def change
    add_column :smtps, :desc, :text
  end
end
