# spec/support/request_helpers.rb
require 'spec_helper'
include Warden::Test::Helpers


module RequestHelpers
  def login_goto
      FactoryGirl.build(:user) do |user|
        user.invite!
        last_email.to.should include(user.email)
        inv_url = Capybara.string(last_email.body.encoded).first(".inbox > a")[:href]
        inv_token = inv_url.split("?")[1]
        inv_url_final = '/users/invitation/accept?' + inv_token
        
        p "****** Inv Url is #{inv_url_final} ******"
        visit inv_url_final
        page.should have_content("Set Your Password")
        
        p "********** Preparing User as Admin ***********"
        temp = UserConfig.first.dup
        temp.def_f_u_ass_to = user.id
        user.conf = temp
        role_id = Role.find_by_name("agency_administrator").id
        user.update_attribute(:role_id, role_id)
        user.update_attribute(:invited_by_id,user.id)
        user.update_attribute(:is_active, true)
        user.permissions << Permission.where(subject_class: "User", action: ["update","read"])
        user.permissions << Role.find(role_id).permissions
        
        p "******* User is an Admin? **********"
        p user.adm?
        
        p "******* Setting current user rto observe **********"
        User.current = user        
        
        p "********** Filling set password form ***********"
        fill_in "user_first_name", :with => "Test First Name"
        fill_in "user_surname", :with => "Test Surname"
        fill_in "user_password", :with => "test_password"
        fill_in "user_password_confirmation", :with => "test_password"
        click_on "Set Now"
        
        p "********** After SET NOW content checking the current_path to be the users path ***********"
        page.current_path.should == '/users/' + user.id.to_s
      end
  end
end
