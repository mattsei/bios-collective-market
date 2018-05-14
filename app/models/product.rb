class Product < ApplicationRecord
  resourcify
  belongs_to :user
  has_many :orders

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
