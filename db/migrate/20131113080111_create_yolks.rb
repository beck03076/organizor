class CreateYolks < ActiveRecord::Migration
  def change
    create_table :yolks do |t|
      t.string :name

      t.timestamps
    end
  end
end
