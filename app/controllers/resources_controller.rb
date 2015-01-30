class ResourcesController < ApplicationController
  def index
    @resources = %w[programme_types application_statuses contact_types course_levels course_subjects doc_categories english_levels enquiry_statuses event_types exam_types partners qualifications student_sources sub_agents tasks task_statuses task_topics]
actions = %w[create read update delete]
  end
  
  def edit
    set_url_params
    @r = @r_name.camelize.constantize.find(@r_id)
  end
  
  def show
    set_url_params
    @r = @r_name.camelize.constantize.find(@r_id)
  end
  
end
