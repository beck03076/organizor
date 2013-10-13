class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :path
      t.string :desc

      t.timestamps
    end
  end
end
