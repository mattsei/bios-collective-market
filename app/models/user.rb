class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true
  
  has_many :products, dependent: :destroy
  def has_role?(*role_names)
    self.roles.where(:name => role_names).present?
  end
end
