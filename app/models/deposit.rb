class Deposit < Transaction
  
  validates :target_account_id, :numericality => true, :presence => true
  validates_associated :target_account
  
  def process
    # add funds to target account
    # add available funds to system
  end
  
end