class GetMessages < DataService
  attr_accessor :room

  def initialize(initial_scope, current_user, room)
    super(initial_scope, current_user)
    @room = room
  end

  private

  def next_link(obj)
    "/api/v1/rooms/#{room.id}/messages?from=#{obj.updated_at.iso8601(3)}"
  end

  def prev_link(obj)
    "/api/v1/rooms/#{room.id}/messages?to=#{obj.updated_at.iso8601(3)}"
  end
end
