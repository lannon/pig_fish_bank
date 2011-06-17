class BalanceInquiriesController < ApplicationController
  before_filter :ensure_params, :only => :create
  
  def new
    @balance_inquiry = BalanceInquiry.new
  end
  
  def create
    @balance_inquiry = BalanceInquiry.create(params[:balance_inquiry])
    if @balance_inquiry.process
      redirect_to @balance_inquiry
    end
  end
  
  def show
    @balance_inquiry = BalanceInquiry.find(params[:id])
    unless customer_account?(@balance_inquiry.source_account)
      redirect_to new_balance_inquiry_path, :status => '301', :notice => "No Can Do"
    end
  end
  
    private
    
      def ensure_params
        if params[:balance_inquiry][:source_account_id].blank?
          redirect_to :back, :notice => "Please select an account" 
        end
      end
end
