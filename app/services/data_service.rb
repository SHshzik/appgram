class DataService
  PER_PAGE = 10
  attr_accessor :initial_scope, :current_user

  def initialize(initial_scope, current_user)
    @initial_scope = initial_scope
    @current_user = current_user
  end

  def call(params)
    scoped = DatetimeFilter.new(initial_scope).call(params)
    response(scoped.limit(PER_PAGE))
  end

  private

  def response(scoped)
    [get_options(scoped), scoped]
  end

  def next_link(obj)
    ''
  end

  def prev_link(obj)
    ''
  end

  def get_options(scoped)
    options = { links: {} }
    options[:links][:next] = next_link(scoped.last) unless scoped.last.nil?
    options[:links][:prev] = prev_link(scoped.first) unless scoped.first.nil?
    options
  end
end
