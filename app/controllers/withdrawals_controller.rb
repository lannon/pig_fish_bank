class WithdrawalsController < ApplicationController
  
  before_filter :ensure_params, :only => :create
  
  def new
    @withdrawal = Withdrawal.new
  end
  
  def create
    @withdrawal = Withdrawal.create(params[:withdrawal])
    if @withdrawal.process
      redirect_to @withdrawal
    end
  end
  
  def show
    @withdrawal = Withdrawal.find(params[:id])
    unless customer_account?(@withdrawal.source_account)
      redirect_to new_withdrawal_path, :status => '301', :notice => "No Can Do"
    end
  end
  
  private
    
    def ensure_params
      if params[:withdrawal][:source_account_id].blank?
        redirect_to :back, :notice => "Please select an account" 
      end
    end
    

end
