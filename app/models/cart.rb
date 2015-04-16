class Cart < ActiveRecord::Base
  has_many :order_items

  before_save do
   update_cart 
  end

  def set_subtotal
    if order_items.size > 0
      self.subtotal = order_items.map(&:total_price).reduce(:+)
    else
      update_attribute(:subtotal, 0)
    end
  end

  def set_tax
    self.tax = subtotal * 0.13   
  end

  def set_shipping
    self.shipping = 100
  end

  def set_grand_total
   self.total =  self.subtotal + self.tax + self.shipping
  end

  def update_cart
    set_subtotal
    set_tax
    set_shipping
    set_grand_total
  end
end
