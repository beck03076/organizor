class UserMetricsController < ApplicationController

  def index
  	set_url_params
  	set_pre 	
    obj = UserMetric.new(@users,@module)
    obj.send(@tab)
    @metrics = obj.all
  end

  def set_pre
  	@users = User.where(id: @uids.split("-"))
  	@metrics = {} 
  	@tab ||= "statistics"  	
  	@core = %w(statistics enquiries registrations institutions people)
  	@style = {statistics: ["stats","orange-well"], enquiries: ["earphone","green-well"], registrations: ["pencil","yellow-well2"],
  	          institutions: ["home","purple-well2"], people: ["globe","blue-well2"]}
  end

  def compare_users_modal
    set_url_params

    @uids = (@uids.nil? ? [] : (@uids.map &:to_i))
    @users = User.all
  end
  
end
 