class AddResponseTimeToPartner < ActiveRecord::Migration
  def change
    add_column :partners, :response_time, :string
  end
end
