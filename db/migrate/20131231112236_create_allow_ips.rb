class CreateAllowIps < ActiveRecord::Migration
  def change
    create_table :allow_ips do |t|
      t.string :from
      t.string :to
      t.text :desc

      t.timestamps
    end
  end
end
