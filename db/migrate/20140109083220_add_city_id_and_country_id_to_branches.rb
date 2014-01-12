class AddCityIdAndCountryIdToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :city_id, :integer
    add_column :branches, :country_id, :integer
  end
end
