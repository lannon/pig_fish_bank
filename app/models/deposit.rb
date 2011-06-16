class Deposit < Transaction
  
  validates :target_account_id, :numericality => true, :presence => true
  validates :amount, :numericality => true, :presence => true
  
  def process
    # add funds to target account
    # add available funds to system
    super do
      target_account.credit(amount)
      Account.system.credit(amount) unless Account.system == target_account
    end
    true
  end
  
end