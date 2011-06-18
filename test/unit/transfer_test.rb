require 'test_helper'

class TransferTest < ActiveSupport::TestCase
  
  context "validations" do
    should validate_presence_of(:target_account_id)
    should validate_presence_of(:source_account_id)
    should validate_presence_of(:amount)
    should validate_numericality_of(:amount)
  end
  
  context "associations" do
    should belong_to(:target_account)
    should belong_to(:source_account)
  end
  
  context "a new transfer" do
    
    
    setup do
      @amount = 100
      @source_account = Factory(:account)
      @target_account = Factory(:account)
      @transfer = Factory(:transfer, 
        :target_account => @target_account,
        :source_account => @source_account, 
        :amount => @amount)
    end
  
    should "respond to process" do     
      assert @transfer.respond_to?(:process)
    end
    
    should "not be succesful upon creation" do
      assert !@transfer.success?
    end
    
    context "before processing" do
      setup do
        @initial_source_account_balance = @source_account.balance
        @initial_target_account_balance = @target_account.balance
      end
      
      should "raise an error if source account has insufficient funds" do
        assert_raise(ActiveRecord::RecordInvalid) { @transfer.process }
      end
      
      # TODO: clean this up
      should "debit funds from source account, add funds to target account and be successful if sufficient funds" do
        new_balance = @source_account.balance = @amount
        @transfer.process
        assert @source_account.balance == new_balance - @amount
        assert @target_account.balance == @initial_target_account_balance + @amount
        assert @transfer.success?
      end
    end
  end
  
  context "a transfer with identical target and source accounts" do
    setup do
      @amount = 100
      @source_account = @target_account = Factory(:account)
      @target_account = Factory(:account)
      @transfer = Factory(:transfer, 
        :target_account => @target_account,
        :source_account => @source_account, 
        :amount => @amount)
    end
    
    should "fail miserably" do
    end
  end
end
