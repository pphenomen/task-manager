class UserFilterDecorator < BaseFilterDecorator
  def filter(params)
    filtered = data
    filtered = filter_by_field(filtered, 'name', params[:name]) if params[:name].present?
    filtered
  end
end
