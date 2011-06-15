class Withdrawal < Transaction
  
  validates :source_account_id, :numericality => true, :presence => true
  validates_associated :source_account
  
  def process
    # take funds from source account 
    # if source account and system have sufficient funds are available
  end
  
end