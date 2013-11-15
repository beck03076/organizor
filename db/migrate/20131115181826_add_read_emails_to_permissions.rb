class AddReadEmailsToPermissions < ActiveRecord::Migration
  def up
     execute <<-SQL
       INSERT INTO `permissions` (`action`, `created_at`, `description`, `name`, `subject_class`, `subject_id`, `subject_var`, `updated_at`) VALUES ('read', '2013-11-15 18:16:49', 'With this permission, an user can create a email', 'read_emails', 'Email', NULL, NULL, '2013-11-15 18:16:49')
    SQL
  end
end
