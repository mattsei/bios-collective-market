class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :buyer_id
      t.integer :seller_id

      t.timestamps
    end
  end
end
