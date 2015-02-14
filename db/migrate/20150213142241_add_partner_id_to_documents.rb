class AddPartnerIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :partner_id, :integer
  end
end
