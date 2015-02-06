class SecondariesController < ApplicationController

  def index
    @resource_name = params["model_name"].titleize
    @model_name = @resource_name.gsub(/ /,'').constantize
    @resources = @model_name.all
  end
end
