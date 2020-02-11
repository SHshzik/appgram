json.array! @rooms do |room|
  json.(room, :created_at, :updated_at)
  json.unread_messages room.count_unread_messages(@current_user)
  json.last_message room.last_message
end
