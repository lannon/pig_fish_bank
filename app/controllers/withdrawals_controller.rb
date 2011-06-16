class WithdrawalsController < ApplicationController

  def new
  end
  
  def create
    @withdrawal = Withdrawal.create(params[:withdrawal])
  end

end
