class Transaction < ActiveRecord::Base

  belongs_to :source_account, :class_name => 'Account'
  belongs_to :target_account, :class_name => 'Account'
  
  validates :type, :presence => true, 
    :inclusion => { :in => ['Withdrawal','Deposit','Transfer','BalanceInquiry'] }
  
  
  def process
    begin
      transaction { yield } 
    rescue => e
      raise e
    else  
      update_attribute(:success, true)
    end
  end
  
end
