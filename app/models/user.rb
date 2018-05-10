class User < ApplicationRecord
  include Authority::UserAbilities
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :products, foreign_key: :author_id
  def has_role?(*role_names)
    self.roles.where(:name => role_names).present?
  end
end
