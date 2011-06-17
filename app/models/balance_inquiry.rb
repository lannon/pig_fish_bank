class BalanceInquiry < Transaction
  
  validates :source_account_id, :numericality => true, :presence => true
  
  def process
    super do 
      # nothing
    end
    source_account.balance
  end
  
end