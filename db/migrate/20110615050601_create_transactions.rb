class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer  :source_account_id
      t.integer  :target_account_id
      t.string   :type
      t.decimal  :amount, :precision => 12, :scale => 2, :default => 0
      t.boolean  :success, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
