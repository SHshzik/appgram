json.results do
  json.array! @rooms do |room|
    json.call(room, :id, :created_at, :updated_at)
    json.unread_messages room.count_unread_messages(@current_user)
    json.last_message room.last_message
    json.user do
      json.call(room.last_user(@current_user), :id, :username, :avatar)
    end
  end
end
