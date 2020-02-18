class DataService
  PER_PAGE = 10
  attr_accessor :initial_scope, :current_user, :per_page

  def initialize(initial_scope, current_user)
    @initial_scope = initial_scope
    @current_user = current_user
  end

  def call(params)
    scoped = DatetimeFilter.new(initial_scope).call(params)
    [options(scoped, params), scoped.limit(per_page(params[:size]))]
  end

  private

  def per_page(size = nil)
    pagination_by = PER_PAGE
    pagination_by = size.to_i unless size.nil?
    pagination_by
  end

  def options(scoped, params)
    data = {
        params: {
            current_user: current_user
        },
    }
    if scoped.count > per_page(params[:size])
      data[:links] = {
          next: "/api/v1/rooms?from=#{scoped.limit(per_page(params[:size])).last.updated_at.iso8601(3)}",
      }
    end
    data
  end
end
