class AddDefaultValueToDone < ActiveRecord::Migration

  def up
    change_column :todos, :done ,:boolean, :default => false
  end
  def down
  end
end
