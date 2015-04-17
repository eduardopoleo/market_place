class Cart < ActiveRecord::Base
  has_many :order_items
  has_one :payment


  def update_subtotal
    if order_items.size > 0
      self.subtotal = order_items.map(&:total_price).reduce(:+)
    else
      update_attribute(:subtotal, 0)
    end
  end

  def update_tax
    update_attribute(:tax, self.subtotal * 0.13)
  end

  def set_shipping
    self.shipping = 100
  end

  def update_grandtotal
   update_attribute(:total, self.subtotal + self.tax + self.shipping)
  end

  def update_cart
    update_subtotal
    update_tax
    set_shipping
    update_grandtotal
  end
end
