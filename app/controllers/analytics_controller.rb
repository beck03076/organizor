class AnalyticsController < ApplicationController

  def index
    

  end

  def show
  	params.delete_if { |k, v| v.blank? }
  	set_url_params
  	set_pre

  	obj = Analytics.new(@core,@core_method,@core_params,@size,@from,@to,@last_months)
  	obj.all_analytics
  	analytics = obj.out
  	
  	analytics.keys.each do |a|
  		if !analytics[a].nil?            
         val = analytics[a]               
         instance_variable_set("@"+a.to_s,val)                            
      end  
  	end
  end

  def set_pre
  	@size ||= 10
  	@from ||= nil
  	@to ||= nil
  	@last_months ||= nil
  end
end
