namespace :db do

  desc "Erase and Fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    include ActionPopulate
    include EnquiryPopulate 
    include RegistrationPopulate 
    include InstitutionPopulate 
    include PersonPopulate 

    %w(Enquiry Registration Programme Fee Commission FollowUp Email Todo Note).each do|m|
      p "Deleting #{m}(s) from 50..500000"  
      m.constantize.where(id: (50..500000)).delete_all
    end    

    @branch = Branch.ids
    @contact_type = contact_type_create    
    #student_source = StudentSource.ids
    @course_level = CourseLevel.ids
    @enquiry_status = EnquiryStatus.ids    
    @sub_agent = Person.sub_agents.ids
    @country = Country.ids
    @city = City.ids
    @gender = ["m","f"]
    @dob = 30.years.ago..20.years.ago
    @created = 2.years.ago..1.month.ago
    @score = [1,2,3,4,5,6,7,8,9,10]
    @user = User.ids
    @programme_type = InstitutionType.edu.ids
    @institution = Institution.ids
    @course_level = CourseLevel.ids
    @bool = [true,false]
    @todo_topic = TodoTopic.ids
    @near_future = 1.week.from_now..6.months.from_now
    @event_type = EventType.ids
    @app_status = ApplicationStatus.ids
    @claim_status = CommissionClaimStatus.ids
    @p_fee = ProcessingFeeType.ids
    @p_fee_status = ProcessingFeeStatus.ids

    start_enquiry_populate
    start_registration_populate
    start_institution_populate
    start_person_populate

  end
end