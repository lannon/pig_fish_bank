require 'test_helper'

class WithdrawalTest < ActiveSupport::TestCase
  
  context "associations" do
    should belong_to(:source_account)
    should validate_presence_of(:amount)
    should validate_numericality_of(:amount)
    
  end
  
  context "validations" do
    should validate_presence_of(:source_account_id)
  end
  
  context "a new withdrawal" do
    
    setup do
     @source_account = Factory(:account)
     @system_account = Account.system
     @amount = 20
     @withdrawal = Factory(:withdrawal, :source_account => @source_account)
    end
  
    should "not be a success upon creation" do
      assert !@withdrawal.success?
    end
    
    should "raise an error if source account balance is less than amount" do
      @source_account.update_attribute(:balance, 0)
      assert_raise(ActiveRecord::RecordInvalid) { @withdrawal.process }
      assert !@withdrawal.success?
    end
    
    should "raise an error if source account balance is sufficient but system balance is insufficient" do
      @source_account.credit(@amount)
      @system_account.update_attribute(:balance, 0)
      assert_raise(ActiveRecord::RecordInvalid) { @withdrawal.process }
      assert !@withdrawal.success?
    end
    
    should "be a success if both balances are sufficient" do
      @source_account.credit(@amount)
      @system_account.credit(@amount)
      @withdrawal.process
      assert @withdrawal.success?
    end
    
    
  end
end
