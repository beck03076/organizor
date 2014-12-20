class AddQualificationNameIdToQualifications < ActiveRecord::Migration
  def change
    add_column :qualifications, :qualification_name_id, :integer
  end
end
