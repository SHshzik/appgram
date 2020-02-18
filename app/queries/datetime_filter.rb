class DatetimeFilter
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def call(params)
    filter_by_datetime(initial_scope, params[:from], params[:to])
  end

  private

  def filter_by_datetime(scoped, from = nil, to = nil)
    scoped = from ? scoped.where('updated_at < ?', DateTime.parse(from)) : scoped
    to ? scoped.where('updated_at > ?', DateTime.parse(to)) : scoped
  end
end