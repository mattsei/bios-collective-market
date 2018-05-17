class Product < ApplicationRecord
  resourcify
  belongs_to :user
  has_many :orders

  validates :name, :description, :price, presence: true
  validates :price, numericality: true, format: { with: /\A\$?[0-9]+\.?[0-9]?[0-9]?\z/, message: "Must be a dollar amount"}
end
