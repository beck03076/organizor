class AddDescToRequiredDoc < ActiveRecord::Migration
  def change
    add_column :required_docs, :desc, :text
  end
end
