class SecondariesController < ApplicationController

  def index
    set_url_params
    @resource_name = @model_name.titleize
    @model_name = @resource_name.gsub(/ /,'').constantize
    @resources = @model_name.all
  end

  def create
    set_url_params
    @model_name.camelize.constantize.create(instance_variable_get("@#{@model_name}"))
    redirect_to "/secondaries/"+@model_name
  end

  def edit
    set_url_params
    @r = @model_name.camelize.constantize.find(@id)
  end

  def show
    set_url_params
    @r = @model_name.camelize.constantize.find(@id)
  end

  def update
    set_url_params
    model_obj = @model_name.camelize.constantize.find(@id)
    model_obj.update_attributes(instance_variable_get("@#{@model_name}"))
    redirect_to "/secondaries/"+@model_name
  end

  def destroy
    set_url_params
    model_object = @model_name.camelize.constantize.find(@id)
    model_object.destroy
    redirect_to "/secondaries/"+@model_name
  end

end
