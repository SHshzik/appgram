unless @messages.next_page.nil?
  json.next_page "/api/v1/rooms/#{@room.id}/messages?from=#{@last_message.updated_at.iso8601(3)}"
end

json.results do
  json.array! @messages, :id, :msg, :status, :sender_id, :room, :created_at, :updated_at
end
