class RenameColumnInPayments < ActiveRecord::Migration
  def change
    rename_column :payments, :refence_id, :reference_id
  end
end
