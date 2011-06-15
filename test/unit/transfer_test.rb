require 'test_helper'

class TransferTest < ActiveSupport::TestCase
  
  
  context "associations" do
    should belong_to(:source_account)
  end
  
  context "a new transfer" do
    
    
  end
end
