class RemoveEnquiryIdAndRegistrationIdAndInstitutionIdAndPersonIdFromFollowUps < ActiveRecord::Migration
  def up
    remove_column :follow_ups, :enquiry_id
    remove_column :follow_ups, :registration_id
    remove_column :follow_ups, :institution_id
    remove_column :follow_ups, :person_id
  end

  def down
    add_column :follow_ups, :person_id, :integer
    add_column :follow_ups, :institution_id, :integer
    add_column :follow_ups, :registration_id, :integer
    add_column :follow_ups, :enquiry_id, :integer
  end
end
