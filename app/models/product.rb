class Product < ApplicationRecord
  resourcify
  include Authority::Abilities
  belongs_to :author, class_name: 'User'
  # belongs_to :user
end
