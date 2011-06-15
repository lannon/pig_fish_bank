require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

  context "validations" do 

    should validate_presence_of(:type)
    should validate_presence_of(:amount)
    should validate_numericality_of(:amount)
  end
  
  context "associations" do
    
    should belong_to(:target_account)
    should belong_to(:source_account)
    
  end
    
    
end
