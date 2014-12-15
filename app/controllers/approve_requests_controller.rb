class ApproveRequestsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :update

  def update
    registration_id = params["registration_id"]
    registration = Registration.find registration_id
    request_to = registration.assigned_to
    values = params["registration"]
    ApproveRequest.create(registration_id: registration_id, request_to: request_to, values: values)
    respond_to do |format|
      format.json { render :json => { :message => "Request sent" } }
    end
  end

  def approve_or_reject
    if request.method == "GET"
      @requests = ApproveRequest.where("request_to = #{current_user.id} and approved = false")
    elsif request.method == "POST"
      binding.pry
      approval = ApproveRequest.find params["id"]
      registration = Registration.find approval.registration_id
      field = approval.values.keys.first
      value = approval.values.values.first
      registration.update_attribute :"#{field}", value
      approval.update_attribute :approved, true
      redirect_to approval_path
    end
  end

  def delete
    request = ApproveRequest.find params["id"]
    request.delete
    redirect_to approval_path
  end
end
