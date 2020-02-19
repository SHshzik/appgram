class MessageForm
  include ActiveModel::Model
  attr_accessor :message, :msg, :user, :room

  validates(
    :msg,
    presence: {
      message: 'Поле msg должно быть заполнено'
    },
    length: {
      minimum: 2,
      message: 'Поле msg должно быть минимум 2 символа'
    }
  )

  def create
    room.messages.create(msg: msg, sender_id: user.id)
  end

  def update
    message.update_attributes(msg: msg)
    message
  end
end
