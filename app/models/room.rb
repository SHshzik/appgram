class Room < ApplicationRecord
  has_many :messages
  has_and_belongs_to_many :users

  def count_unread_messages(user)
    messages.where.not({ sender_id: user.id }).where({ status: false }).count
  end

  def last_message
    messages.first.msg
  end
end
