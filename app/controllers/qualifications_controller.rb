class QualificationsController < ApplicationController

  def show
    @qualifications =  Registration.find(params[:id]).qualifications
    respond_to do |format|
      format.js
    end
  end

end
