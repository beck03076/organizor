class AddEducationalToPartnerTypes < ActiveRecord::Migration
  def change
    add_column :partner_types, :educational, :boolean
  end
end
