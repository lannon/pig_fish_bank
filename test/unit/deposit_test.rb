require 'test_helper'

class DepositTest < ActiveSupport::TestCase
  
  context "associations" do
    should belong_to(:target_account)
  end
  
  context "validations" do
    should validate_presence_of(:target_account_id)
    should validate_presence_of(:amount)
    should validate_numericality_of(:amount)
    
  end
  
  context "a new deposit" do
    
    setup do
      @amount = 100
      @account = Factory(:account)
      @deposit = Factory(:deposit, :target_account => @account, 
        :amount => @amount)
    end
  
    should "respond to process" do     
      assert @deposit.respond_to?(:process)
    end
    
    should "not be succesful upon creation" do
      assert !@deposit.success?
    end
    
    context "when processed" do
      setup do
        @initial_account_balance = @account.balance
        @initial_system_balance = Account.system.balance
        @deposit.process
      end
      
      should "add funds to the target account" do
        assert @deposit.target_account.balance == @initial_account_balance + @amount
      end
      
      should "add funds to the system account" do
        assert Account.system.balance == @initial_system_balance + @amount
      end
      
      should "be successful" do
        assert @deposit.success?
      end
    end 
  
  end
end
