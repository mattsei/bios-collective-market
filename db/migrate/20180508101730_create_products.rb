class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :product_id
      t.decimal :price
      t.integer :stock
      t.string :owner
      t.text :description

      t.timestamps
    end
  end
end
