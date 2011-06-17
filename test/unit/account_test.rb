require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:customer)
  end
  
  context "validations" do
    should validate_numericality_of(:balance)
    should validate_presence_of(:balance)
    should validate_presence_of(:account_type)
  end
  
  context "a new account" do
    
    setup do
      @account = Factory(:account)
    end
  
    should "start with a balance of 0" do
      assert @account.balance == 0
    end
    
    
  end
  
  context "a system account" do
    setup do
      @account = Account.system
    end
    
    should "be globally unique. cannot create more than one" do
      @new_system_account =  Account.create(:account_type => 'system')
      assert !@new_system_account.save
    end
    
  end
end
