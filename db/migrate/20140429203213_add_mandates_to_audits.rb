class AddMandatesToAudits < ActiveRecord::Migration
  def change
    add_column :audits, :checked, :boolean
    add_column :audits, :receiver_id, :integer
    add_column :audits, :meta, :text
    add_column :audits, :title, :string

  end
end
