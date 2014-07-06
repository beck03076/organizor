class TypeaheadsController < ApplicationController
	def results
	  model = params[:models].singularize.camelize.constantize	
      results = model.where("#{params[:col]} LIKE '%#{params[:q]}%'")      
      render json: results
    end
end
