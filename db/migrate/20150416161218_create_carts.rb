class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :subtotal
      t.integer :tax
      t.integer :shipping
      t.integer :total
      t.boolean :active
    end
  end
end
