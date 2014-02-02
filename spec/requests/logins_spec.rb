require 'spec_helper'

describe "LoginSpec" do

=begin
   include EmailSpec::Helpers
   include EmailSpec::Matchers
   
    it "login page works" do
      get '/users/sign_in'
      response.status.should be(200)
    end
    
    it "invite user and check invitation sent and visit invitation url, prepare user, check if the user logs into the right landing page(users page)" do 
      login_goto        
      end
    end

    it "See enquiries page" do 
      login_goto
      p "******** Clicking on Enquiries ******"
      page.first("li#enquiries > a").click
      page.current_path.should == '/enquiries'

    end
=end
    it "Click enquiries tabs", :js => true do 
      login_goto
      p "******** Creating 20 enquiries ******"
      20.times { FactoryGirl.create(:enquiry) do |e|
                   p "**** Enquiry First Names ****"
                   p e.first_name
                 end
       }
      p "******** Clicking on Enquiries ******"
      page.first("li#enquiries > a").click
      page.current_path.should == '/enquiries'
      
      p "******** Print Enquiries ******"
      p Enquiry.myactive(User.current)
      
      ["all","pending","following","deactivated"].each do |i|
         p "+++ Clicking on Enquiries - #{i} +++"
         page.first("ul.seperator li#" + i + " > a").click
         sleep(inspection_time=15)
      end
    end
    
end

