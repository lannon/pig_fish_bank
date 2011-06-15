class BalanceInquiry < Transaction
  
  validates :target_account_id, :numericality => true, :presence => true
  validates_associated :target_account
  
  def process
    # show fund availabe in target account
    target_account
  end
  
end