class AddTimestampsToCarts < ActiveRecord::Migration
  def change
    add_column(:carts, :created_at, :datetime)
    add_column(:carts, :updated_at, :datetime)
  end
end
