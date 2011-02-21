class AuthenticationsController < ApplicationController

  def create
    render :text => request.env["omniauth.auth"]
  end
  
  def failure
    logger.info { params[:message] }
    flash[:notice] = params[:message]
  end
end
