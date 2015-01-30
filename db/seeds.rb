# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
=begin
["language_school","university"].each do |i|
    p "Creating a programme type .. #{i}"
    role = ProgrammeType.create!(:name => i)
end
=end

["agency_administrator","branch_user",
 "branch_manager","regional_manager",
 "student","sub_agent","school"].each do |i|
   if Role.where(name: i).blank?
     p "Creating a role .. #{i}"
     role = Role.create!(:name => i)
   end
 end

 if Permission.where(subject_class: "All",action: "manage").blank?
   p "Creating admin permissions..."
   @admin = Permission.create!(:name => "manage_all",
                               :description => "With this permission, an user can do everything",
                               :subject_class => "All",
                               :action => "manage")
 end

 @user = User.first_adm
 if @user.nil?
   @user = User.invite!(email: "senthilkumar.hce@gmail.com")
   @user.update_attribute(:invited_by_id,1)
   @user.update_attribute(:is_active, true)
   PermissionsUser.create! user_id: @user.id, permission_id: @admin.id
 end

 models = %w[contracts finances students users enquiries registrations countries programme_types cities application_statuses contact_types course_levels course_subjects doc_categories documents emails email_templates english_levels enquiry_statuses event_types exams exam_types follow_ups partners notes programmes qualification_names roles smtps student_sources sub_agents tasks task_statuses task_topics people audit required_doc required_doc_type]
 actions = %w[create read update delete]
 models.each do |m|
   actions.each do |a|
     if Permission.where(subject_class: m.singularize.titleize.gsub(/ /,""),action: a).blank?
       p "Creating #{m} for #{a} permissions..."
       Permission.create!(:name => "#{a}_#{m}",
                          :description => "With this permission, an user can #{a} a #{m.singularize}",
                          :subject_class => "#{m.singularize.titleize.gsub(/ /,"")}",
                          :action => "#{a}")
     end                    
   end
 end


 if Permission.where(subject_class: "Document",action: "upload").blank?
   p "Creating document upload permissions..."
   Permission.create!(:name => "upload_documents",
                      :description => "With this permission, an user can upload documents",
                      :subject_class => "Document",
                      :action => "upload")
   p "created.."
 end
 if Permission.where(subject_class: "Document",action: "download").blank?
   p "Creating documnet download permissions..."
   Permission.create!(:name => "download_documents",
                      :description => "With this permission, an user can download documents",
                      :subject_class => "Document",
                      :action => "download")
   p "created.."
 end

 if Permission.where(subject_class: "Registration",action: "approve").blank?
   p "Creating approve request permissions..."
   Permission.create!(:name => "approve_registrations",
                      :description => "With this permission, an user can approve registrations",
                      :subject_class => "Registration",
                      :action => "approve")
   p "created.."
 end

 if Permission.where(subject_class: "Comment",action: "create").blank?
   p "Creating create comments permissions..."
   Permission.create!(:name => "create_comments",
                      :description => "With this permission, an user can approve registrations",
                      :subject_class => "Comment",
                      :action => "create")
   p "created.."
 end

 # my models permissions
 %w(Enquiry Registration Partner Person).each do |m|
   %w(read update).each do |a|
     if Permission.where(subject_class: m,action: a,subject_id: 1).blank?
       p "Creating #{m} for #{a} permissions (mine)..."
       Permission.create!(:name => "#{a}_#{m.downcase.pluralize}",
                          :description => "With this permission, an user can #{a} a #{m.singularize} assigned to him",
                          :subject_class => "#{m}",
                          :action => "#{a}",
                          :subject_id => 1)
     end
   end 
 end

 # only core models permissions
 %w(Enquiry Registration Partner Person).each do |m|
   %w(list).each do |a|
     if Permission.where(subject_class: m,action: a).blank?
       p "Creating #{m} for #{a} permissions (mine)..."
       Permission.create!(:name => "#{a}_#{m}",
                          :description => "With this permission, an user can #{a} a #{m.singularize} assigned to him",
                          :subject_class => "#{m}",
                          :action => "#{a}")
     end
   end 
 end


 if (UserConfig.all.size == 0)

   p "Creating User Config.."

   UserConfig.create!(def_follow_up_days: 2, 
                      user_id: nil, 
                      def_note: "This is a configurable note", 
                      reg_cols: [[:assigned_to, :_ass_to, :first_name], :branch_id, [:country_id, :country_of_origin, :name], :first_name, :ref_no], 
                      enq_cols: [[:country_id, :country_of_origin, :name], :email2, :first_name],
                      def_enq_email: "email1",
                      def_reg_email: "email1",
                      def_create_enquiry_email: "Welcome Enquiry",
                      def_from_email: "Senthil Gmail",
                      def_f_u_name: "First Follow Up",
                      def_f_u_desc: "This is the first follow up",
                      def_f_u_type: 1,
                      auto_cr_f_u: true,
                      auto_email_enq: true,
                      def_f_u_ass_to: 1,
                      def_enq_search_col: "date_of_birth",
                      def_reg_search_col: "first_name",
                      def_ins_search_col: "name",
                      ins_cols: [:email, :name],
                      def_per_search_col: "first_name",
                      per_cols: [[:city_id, :city, :name], [:country_id, :country, :name], :created_by, :first_name, :gender, [:partner_id, :partner, :name], :surname, [:type_id, :type, :name]])

   p "Created User config with nil as user id, use it!"
 end
 # =====
 # setting this to update created_by  - admin user as first user
 p "setting this to update created_by  - admin user as first user.."
 User.current = User.first
 # =====

 if (AllowIp.all.size == 0)
   p "Creating allow ip range for localhost 127.0.0.1 .."
   AllowIp.create!(from: "127.0.0.1", to: "127.0.0.1", desc: "localhost")
 end


 [{application_status: %w(Sent Conditional_offer Unconditional_offer 
                         Pending Joined Rejected Deferred Sent_to_documentation)},
                         {commission_status: %w(Pending Partially_paid fully_paid)},
                         {contact_type: %w(Walk-in Telephone Email Online Event Sub_Agent)},
                         {course_level: %w(Foundation A-level Diploma Bachelor Pre-master PgDiploma Master PhD)},
                         {doc_category: %w(English Foundation Bachelor Masters Phd)},
                         {english_level: %w(Beginner Elementary Pre-intermediate Intermediate Advanced)},
                         {enquiry_status: %w(Pending Following Deactivated)},
                         {event_type: %w(Call Email Sms Meet)},
                         {exam_type: %w(IELTS TOEFL FCE Pearson)},
                         {partner_group: %w(ABC DEF PQR XYZ)},
                         {partner_type: %w(University Language_School Business_Partner 
                       Education_Provider Official_Sub_Agent Private_Provider)},
                       {person_type: %w(contact unofficial_sub_agent personal)},
                       {qualification_name: %w(School_certificate Foundation A-level
                    Diploma Bachelor Pre-master 
                    PgDiploma Master PhD)},
                    {student_source: %w(Forum Google_Search Google_Advert 
                     Website Education_Event Friend)},
                     {task_topic: %w(Default Documents Administrative
                 Enquiry Registration Partner 
                 Person)},
                 {commission_claim_status: %w(Claimed Claim_Confirmed Invoiced Credit_Note_Raised Full_Payment_Received Partial_Payment_Received)},
                 {progression_status: %w(Progression_UG Progression_PG Progression_Complete Non_Progression )},
                 {processing_fee_type: %w(Admin_Fee Processing_Fee Logistics_Fee)},
                 {processing_fee_status: %w(Paid Unpaid Partially_paid Refunded)},
                 {required_doc: %w(language_course bachelors masters)},
                 {required_doc_type: %w(IELTS TOEFL FCE Pearson 10th_mark_sheet CAS VISA)}].each do |i|
                   model = i.keys[0].to_s.camelize.constantize
                   values = i.values[0]
                   values.each do |v|
                     if model.where(name: v.titleize).blank?
                       p "Creating a value .. #{v} in the resource #{model}"
                       model.create!(name: v.titleize, desc: "This is a default value.")
                     end
                   end
                 end


