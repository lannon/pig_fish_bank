class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table   :accounts do |t|
      t.string     :account_type
      t.decimal    :balance, :precision => 12, :scale => 2, :default => 0
      t.belongs_to :customer
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
