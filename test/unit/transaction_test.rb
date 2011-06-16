require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

  context "validations" do 
    should validate_presence_of(:type)
  end
  
  
  context "a transaction" do
    setup do
      # Deposit < Transaction
      # Transaction is an abstract class
      @transaction = Factory(:deposit) 
    end
    
    should "respond to process" do
      assert @transaction.respond_to?(:process)
    end
    
  end
    
    
end
