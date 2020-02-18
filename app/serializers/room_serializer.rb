class RoomSerializer
  include FastJsonapi::ObjectSerializer
  set_type :room
  attributes :created_at, :updated_at
  attribute :last_message
  attribute :unread_messages do |room, params|
    room.count_unread_messages(params[:current_user])
  end
  has_many :users, serializer: UserSerializer
end
