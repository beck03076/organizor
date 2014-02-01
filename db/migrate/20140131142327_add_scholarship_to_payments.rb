class AddScholarshipToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :scholarship, :float
  end
end
