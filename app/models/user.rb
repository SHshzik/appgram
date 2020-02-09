class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :phone, uniqueness: true, presence: true
  has_and_belongs_to_many :rooms
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
end
