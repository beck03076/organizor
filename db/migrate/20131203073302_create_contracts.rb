class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :name
      t.date :initiate_date
      t.string :current_contract_start_date
      t.string :current_contract_end_date
      t.date :renewal_reminder_date
      t.string :commission_rate
      t.string :invoicing_deadline
      t.string :partners_target
      t.string :internal_target
      t.string :recruitment_territories
      t.text :desc
      t.integer :partner_id

      t.timestamps
    end
  end
end
