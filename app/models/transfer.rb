class Transfer < Transaction
  
  validates :target_account_id, :numericality => true, :presence => true
  validates :source_account_id, :numericality => true, :presence => true
  validates :amount, :numericality => true, :presence => true
  
  def process
    # debit source account
    # credit target account
    # don't worry about balances. account validations should raise errors
    super do
      source_account.debit(amount)
      target_account.credit(amount) 
    end
    true
  end
  
end