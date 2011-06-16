class Customer < ActiveRecord::Base
  
  MAX_LOGIN_ATTEMPTS = 3
  
  attr_accessor :pin
  
  has_many :accounts
  has_many :transactions, :through => :accounts
  
  validates :balance, :presence => true, :numericality => true
  validates :pin, :presence => true, :numericality => true, 
    :length => {:is => 4}, :on => :create
  validates :name, :presence => true, :uniqueness => true, 
    :length => { :within => 3..100 }
  validates_associated :accounts
  
  def self.authenticate(name, pin)
    if customer = self.find_by_name(name)
      if BCrypt::Password.new(customer.pin_digest) == pin
        customer
      else
        customer.failed_attempt!
        nil
      end
    end   
  end

  def pin=(new_pin)
    @pin = new_pin
    self.pin_digest = BCrypt::Password.create(new_pin)
  end
  
  def locked?
    failed_attempts >= 3
  end
  
  def failed_attempt!
    update_attribute(:failed_attempts, self.failed_attempts += 1)
  end
  
  def unlock!
    update_attribute(:failed_attempts, 0)
  end
  
end
