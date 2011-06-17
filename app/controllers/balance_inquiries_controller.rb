class BalanceInquiriesController < ApplicationController
  
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
  
end
