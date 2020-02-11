class Room < ApplicationRecord
  has_many :messages
  has_and_belongs_to_many :users # TODO: add require

  def count_unread_messages(user)
    self.messages.where.not({ sender_id: user.id }).where({ status: false }).count
  end

  def last_message
    self.messages.first.msg
  end
end
