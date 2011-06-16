require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  
  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:pin)
    should validate_presence_of(:balance)
    should validate_numericality_of(:pin)
    should validate_numericality_of(:balance)
  end
  
  context "associations" do
    should have_many(:accounts)
  end
  
  context "customer authentication" do 
    
    setup do
      @customer_attributes = {:name => 'John', :pin => 1234}
      @customer = Factory(:customer, @customer_attributes)
    end
    
    should "return nil if authentication fails" do
      assert_nil Customer.authenticate('BadCompany','TilTheDayIDie')
    end
    
    should "return customer if authenication succeeds and account is not locked" do
      assert @customer == Customer.authenticate(@customer_attributes[:name], @customer_attributes[:pin])
    end
    
    should "be locked out after 3 login attempts" do
      3.times { Customer.authenticate(@customer_attributes[:name], "#{@customer_attributes[:pin]}BAD")}
      assert @customer.reload.locked?
    end
    
    should "not be able to authenticate even with correct pin after 3 unsuccessful login attempts" do
      3.times { Customer.authenticate(@customer_attributes[:name], "#{@customer_attributes[:pin]}BAD")}
      assert Customer.authenticate(@customer_attributes[:name], @customer_attributes[:pin]).locked?
    end
    
  end
  
  context "a locked out customer" do
    
    setup do
      @customer_attributes = {:name => 'Biff', :pin => 5677, :failed_attempts => 3}
      @customer = Factory(:customer, @customer_attributes)
    end
    
    should "be locked" do
      assert @customer.locked?
    end
    
    should "be unlockable" do
      @customer.unlock!
      assert !@customer.locked?
    end
    
  end
  
end
