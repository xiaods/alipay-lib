class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :order_code
      t.integer :pay_type_id
      t.float :total_price
      t.string :cell_phone

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
