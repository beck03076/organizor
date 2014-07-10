class AddIndexToInstitutionNames < ActiveRecord::Migration
  def change
  	  add_index :institutions,:name
  end
end
