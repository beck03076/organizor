class AddDefaultValueToDone < ActiveRecord::Migration

  def up
    change_column :tasks, :done ,:boolean, :default => false
  end
  def down
  end
end
