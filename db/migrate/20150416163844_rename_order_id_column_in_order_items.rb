class RenameOrderIdColumnInOrderItems < ActiveRecord::Migration
  def change
    rename_column :order_items, :order_id, :cart_id
  end
end
