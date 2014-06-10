class AddConversionTimeToProgrammes < ActiveRecord::Migration
  def change
    add_column :programmes, :conversion_time, :string
  end
end
