class Account < ActiveRecord::Base
  
  belongs_to :customer
  has_many :transactions
  
  validates :balance, :presence => true, :numericality => true
  validates :account_type, :presence => true, 
    :inclusion => { :in => ['checking','savings','system'] }
  validates_associated :customer
  validates_associated :transactions
  validates_uniqueness_of :account_type, 
    :if => Proc.new { |account| account.account_type == 'system' }
    
  def self.system
    find_or_create_by_account_type('system')
  end
  
  def withdraw(amount)
    if balance >= amount && system.balance >= amount
      transaction do
        [self, system].uniq.each do |klass|
          klass.transactions.create(:transaction_type => 'withdrawal', :amount => -(amount))
        end
      end
    end
  end
  
  def deposit(amount)
    transaction do
      [self, system].uniq.each do |klass|
        klass.transactions.create(:transaction_type => 'deposit', :amount => amount)
        
      end
    end
  end
  
end
