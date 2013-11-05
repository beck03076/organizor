class ResourcesController < ApplicationController
  def index
    @resources = %w[programme_types application_statuses contact_types course_levels course_subjects doc_categories english_levels enquiry_statuses event_types exam_types institutions qualifications student_sources sub_agents todos todo_statuses todo_topics]
actions = %w[create read update delete]
  end
end
