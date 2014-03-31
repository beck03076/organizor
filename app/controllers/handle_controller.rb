class HandleController < ApplicationController
  layout :false
  def error
    @msg = params[:msg]
  end

  def cancan
  end
  
  def e_500
  end
end
