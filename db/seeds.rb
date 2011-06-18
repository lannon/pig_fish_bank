# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

## People
# | Person | Pin  | Balance |
# | Alice  | 7643 | 2000    |
# | Bob    | 5954 | 22400   |  
# | Clyde  | 1562 | 100     |
alice, bob, clyde = Customer.create(
  [{:name => "Alice", :pin => 7643},
  {:name => "Bob", :pin => 5954},
  {:name => "Clyde", :pin => 1562}]
)
alice.accounts.create(:account_type => 'checking', :balance => 2000)
bob.accounts.create(:account_type => 'checking', :balance => 22400)
clyde.accounts.create(:account_type => 'checking', :balance => 100)

Account.system.update_attribute(:balance, 10000)