class TypeaheadsController < ApplicationController
	#authorize_resource :class => false
	def results
	  model = params[:models].singularize.camelize.constantize	
      results = (model.tire.search params[:q]).results.to_json
      #where("#{params[:col]} LIKE '#{params[:q]}%'").to_json      
      render text: results
    end
end
