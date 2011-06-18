class DepositsController < ApplicationController
  
  before_filter :ensure_params, :only => :create
  
  def new
    @deposit = Deposit.new
  end
  
  def create
    @deposit = Deposit.create(params[:deposit])
    if @deposit.process
      redirect_to @deposit
    end
  end
  
  def show
    @deposit = Deposit.find(params[:id])
    unless customer_account?(@deposit.target_account)
      redirect_to new_deposit_path, :status => '301', :notice => "No Can Do"
    end
  end
  
  private
  
    def ensure_params
      if params[:deposit][:target_account_id].blank?
        redirect_to :back, :notice => "Please select an account" and return
      end
      if params[:deposit][:amount].blank? || params[:deposit][:amount].to_i == 0
        redirect_to :back, :notice => "Please give us the monies." and return
      end
    end
  
end
