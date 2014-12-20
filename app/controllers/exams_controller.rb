class ExamsController < ApplicationController
  def show
    @exams = Registration.find(params[:id]).proficiency_exams.order(:exam_date)
    respond_to do |format|
      format.js
    end
  end
end
