class WithdrawalsController < ApplicationController

  def new
  end
  
  def create
    @withdrawal = Withdrawal.create(params[:withdrawal])
    if @withdrawal.process
      
    end
  end

end
