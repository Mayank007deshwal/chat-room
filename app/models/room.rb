class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages, foreign_key: 'user_id'
end
