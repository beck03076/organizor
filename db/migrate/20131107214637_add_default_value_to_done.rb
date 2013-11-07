class AddDefaultValueToDone < ActiveRecord::Migration

  def up
    change_column :todos, :done ,:boolean, :default => true
  end
  def down
  end
end
