class Product < ActiveRecord::Base
  validates :name, :description, presence: true
  validates :price,
    presence: true,
    numericality: {only_integer: true, greater_than: 0}


  has_many :order_items
  mount_uploader :cover, ProductCoverUploader
end
