class Product < ActiveRecord::Base
  has_many :order_items
  mount_uploader :cover, ProductCoverUploader
end
