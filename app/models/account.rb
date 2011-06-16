class Account < ActiveRecord::Base
  
  belongs_to :customer
  
  validates_presence_of :balance
  validates_numericality_of :balance, :greater_than_or_equal_to => 0
  validates :account_type, :presence => true, 
    :inclusion => { :in => ['checking','savings','system'] }
  validates_associated :customer
  validates_uniqueness_of :account_type, 
    :if => Proc.new { |account| account.account_type == 'system' }
    
  def self.system
    find_or_create_by_account_type('system')
  end
  
  def credit(amount)
   update_attributes!(:balance => balance + amount)
  end
  
  def debit(amount)
    update_attributes!(:balance => balance - amount)
  end
  
end
