class User < ApplicationRecord
  has_and_belongs_to_many :rooms
  validates :username, uniqueness: true, presence: true
end
