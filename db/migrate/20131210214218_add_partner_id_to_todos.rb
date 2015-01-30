class AddPartnerIdToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :partner_id, :integer
  end
end
