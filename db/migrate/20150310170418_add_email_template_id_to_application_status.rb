class AddEmailTemplateIdToApplicationStatus < ActiveRecord::Migration
  def change
    add_column :application_statuses, :email_template_id, :integer
  end
end
