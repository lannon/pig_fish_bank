class DepositsController < ApplicationController

  def new
    @deposit = Deposit.new
  end
  
  def create
    @deposit = Deposit.create(params[:deposit])
    if @deposit.process
      redirect_to @deposit
    end
  end
  
end
