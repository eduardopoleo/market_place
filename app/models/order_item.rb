class OrderItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  validates :quantity,
    presence: true,
    numericality: {only_integer: true, greater_than: 0}
  before_save {total_price}

  def total_price
    self.total_price = self.unit_price * self.quantity
  end
end
