class SessionsController < ApplicationController
  skip_before_filter :authenticate_customer!, :except => :destroy
  
  def new
    render :layout => 'login'
  end
  
  def create
    customer = Customer.authenticate(params[:name], params[:pin])
    if customer && !customer.locked?
      session[:customer_id] = customer.id
      redirect_to root_path, :notice => "Logged in as #{customer.name}"
    else
      flash.now.alert = if customer
        "Too many login attempts. Please contact the Pig Fish."
      else
        "Unable to login"
      end
      render :new, :layout => 'login'
    end
  end
  
  def destroy
    reset_session
    redirect_to login_path
  end
end
