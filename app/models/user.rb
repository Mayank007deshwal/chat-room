class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, uniqueness: true
  has_many :messages

  before_validation :create_username

  def create_username
    self.username = email.split('@')[0]
  end
end
