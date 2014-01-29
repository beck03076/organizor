require 'spec_helper'

describe "LoginSpec" do
   include EmailSpec::Helpers
   include EmailSpec::Matchers
   
    it "login page works" do
      get '/users/sign_in'
      response.status.should be(200)
    end
    
    it "invite user and check invitation sent and visit invitation url, prepare user, check if the user logs into the right landing page(users page)" do 
      build(:user) do |user|
        user.invite!
        last_email.to.should include(user.email)
        inv_url = Capybara.string(last_email.body.encoded).first(".inbox > a")[:href]
        visit inv_url
        page.should have_content("Set Your Password")
        
        p "********** Preparing User ***********"
        role_id = Role.find_by_name("branch_user").id
        user.update_attribute(:role_id, role_id)
        user.update_attribute(:invited_by_id,user.id)
        user.update_attribute(:is_active, true)
        user.permissions << Permission.where(subject_class: "User", action: ["update","read"])
        user.permissions << Role.find(role_id).permissions
        
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

