class ApproveRequestsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :update

  def update
    registration_id = params["registration_id"]
    registration = Registration.find registration_id
    request_to = registration.assigned_to
    values = params["registration"]
    if ApproveRequest.create(registration_id: registration_id, request_to: request_to, values: values)
      flash.now[:notice] = 'Your request will be verified soon by our team'
    else
      flash.now[:alert] = 'Error while sending request!'
    end
  end

  def approve_or_reject
    if request.method == "GET"
      @request = ApproveRequest.where("request_to = #{current_user.id} and approved = false")
    elsif request.method == "POST"
      approval = ApproveRequest.find params["id"]
      registration = Registration.find approval.registration_id
      field = approval.values.keys.first
      value = approval.values.values.first
      registration.update_attribute :"#{field}", value
      approval.update_attribute :approved, true
      redirect_to approval_path
    end
  end
end
