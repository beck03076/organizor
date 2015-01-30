class AddIndexToPartnerNames < ActiveRecord::Migration
  def change
  	  add_index :partners,:name
  end
end
