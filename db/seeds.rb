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
    p "Creating a role .. #{i}"
    role = Role.create!(:name => i)
end

p "Creating permissions..."
Permission.create!(:name => "manage_all",
                       :description => "With this permission, an user can do everything",
                       :subject_class => "All",
                       :action => "manage")
models = %w[users enquiries registrations countries programme_types cities application_statuses contact_types course_levels course_subjects doc_categories documents emails email_templates english_levels enquiry_statuses event_types exams exam_types follow_ups institutions notes programmes qualifications roles smtps student_sources sub_agents todos todo_statuses todo_topics]
actions = %w[create read update delete]
models.each do |m|
  actions.each do |a|
    Permission.create!(:name => "#{a}_#{m}",
                       :description => "With this permission, an user can #{a} a #{m.singularize}",
                       :subject_class => "#{m.singularize.titleize.gsub(/ /,"")}",
                       :action => "#{a}")
   end
end
