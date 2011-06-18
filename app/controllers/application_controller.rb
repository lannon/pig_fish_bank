class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  before_filter :authenticate_customer!
  helper_method :customer_signed_in? , :current_customer
  respond_to :html, :xml, :json
  
  private
    
    def customer_signed_in?
      current_customer ? true : false
    end
    
    def current_customer
      @current_customer ||= Customer.find_by_id(session[:customer_id])
    end
    
    def authenticate_customer!
      customer_signed_in? or redirect_to login_path, :notice => 'You must be signed in'
    end
    
    def customer_account?(account)
      current_customer.accounts.include?(account)
    end
    
    

end
