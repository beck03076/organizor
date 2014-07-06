class CreateTypeaheads < ActiveRecord::Migration
  def change
    create_table :typeaheads do |t|

      t.timestamps
    end
  end
end
