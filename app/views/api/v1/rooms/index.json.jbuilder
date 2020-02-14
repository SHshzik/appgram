json.next_page '/api/v1/rooms?from=%s' % @last_room.updated_at.iso8601(3)

json.results do
  json.array! @rooms do |room|
    json.call(room, :id, :created_at, :updated_at)
    json.unread_messages room.count_unread_messages(@current_user)
    json.last_message room.last_message
  end
end
