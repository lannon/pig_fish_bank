class Transaction < ActiveRecord::Base

  belongs_to :source_account, :class_name => 'Account'
  belongs_to :target_account, :class_name => 'Account'
  
  validates :type, :presence => true, 
    :inclusion => { :in => ['Withdrawal','Deposit','Transfer','BalanceInquiry'] }
  validates :amount, :numericality => true, :presence => true

  
  def process
    # implement in subclass
  end
  
end
