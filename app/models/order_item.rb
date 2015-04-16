class OrderItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  before_save {total_price}

  def total_price
    self.total_price = self.unit_price * self.quantity
  end
end
