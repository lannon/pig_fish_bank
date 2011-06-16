class Withdrawal < Transaction
  
  validates :source_account_id, :numericality => true, :presence => true
  validates :amount, :numericality => true, :presence => true
  
  def process
    super do
      source_account.debit(amount)
      Account.system.debit(amount) unless Account.system == source_account
    end
    true
  end
  
end