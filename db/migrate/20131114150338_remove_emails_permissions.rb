class RemoveEmailsPermissions < ActiveRecord::Migration
  def up
     execute <<-SQL

      DELETE FROM permissions WHERE subject_class="Email" AND action IN ("update","read","destroy")

    SQL
  end

  def down
  end
end
