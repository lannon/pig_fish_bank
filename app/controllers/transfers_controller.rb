class TransfersController < ApplicationController
  
  before_filter :ensure_params, :only => :create
  
  def new
    @transfer = Transfer.new
  end
  
  def create
    @transfer = Transfer.create(params[:transfer])
    if @transfer.process
      redirect_to @transfer
    end
  end
  
  def show
    @transfer = Transfer.find(params[:transfer])
    unless customer_account?(@transfer.target_account) && customer_account?(@transfer.source_account)
      redirect_to new_transfer_path, :status => '301', :notice => "No Can Do"
    end
  end
  
  private
    
    def ensure_params
      if params[:transfer][:target_account_id].blank? || params[:transfer][:source_account_id].blank?
        redirect_to :back, :notice => "Please select source and target accounts"  and return
      end
      if params[:transfer][:target_account_id] == params[:transfer][:source_account_id]
        redirect_to :back, :notice => "Please select distinct source and target accounts" 
      end
    end

end
