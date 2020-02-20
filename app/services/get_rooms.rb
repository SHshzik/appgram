class GetRooms < DataService
  private

  def get_options(scoped)
    options = super
    options[:params] = {}
    options[:params][:current_user] = current_user
    options
  end

  def next_link(obj)
    "/api/v1/rooms?from=#{obj.updated_at.iso8601(3)}"
  end

  def prev_link(obj)
    "/api/v1/rooms?to=#{obj.updated_at.iso8601(3)}"
  end
end
