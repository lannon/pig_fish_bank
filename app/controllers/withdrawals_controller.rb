class WithdrawalsController < ApplicationController

  def new
    @withdrawal = Withdrawal.new
  end
  
  def create
    @withdrawal = Withdrawal.create(params[:withdrawal])
    if @withdrawal.process
      
    end
  end

end
