class AddPaymentIdToCart < ActiveRecord::Migration
  def change
    add_column :payments, :cart_id, :integer
  end
end
