class Product < ApplicationRecord
  resourcify
  belongs_to :user
  has_many :orders

  mount_uploader :product_image, ProductImageUploader

  validates :name, :description, :price, presence: true
  validates :price, numericality: true, format: { with: /\A\$?[0-9]+\.?[0-9]?[0-9]?\z/, message: "Must be a dollar amount"}



  scope(:product_name, -> (name) { where("name like ?", "#{name}%")})
  # scope(:owner, -> (product_user) { where owner: @product_user})
  scope(:price, -> (price) { where price: price })

end
