class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string   :name
      t.string   :pin_digest
      t.decimal  :balance, :precision => 12, :scale => 2, :default => 0
      t.integer  :failed_attempts, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
