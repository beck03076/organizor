class TypeaheadsController < ApplicationController
	authorize_resource :class => false
	def results
	  model = params[:models].singularize.camelize.constantize	
      results = model.where("#{params[:col]} LIKE '#{params[:q]}%'").to_json      
      render text: results
    end
end
