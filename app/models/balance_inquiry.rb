class BalanceInquiry < Transaction
  
  validates :source_account_id, :numericality => true, :presence => true
  
  def process
    super
    source_account.balance
  end
  
end