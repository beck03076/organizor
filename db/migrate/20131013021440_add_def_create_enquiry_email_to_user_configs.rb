class AddDefCreateEnquiryEmailToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_create_enquiry_email, :string
  end
end
