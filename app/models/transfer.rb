class Transfer < Transaction
  
  validates :target_account_id, :numericality => true, :presence => true
  validates_associated :target_account
  validates :source_account_id, :numericality => true, :presence => true
  validates_associated :source_account
  
  def process
    # take money from source account if sufficient funds are available
    # move to target account
    # does not involve ATM cash balance
  end
  
end