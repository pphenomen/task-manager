class ProjectFilterDecorator < BaseFilterDecorator
  def filter(params)
    filtered = data
    filtered = filter_by_field(filtered, 'title', params[:title]) if params[:title].present?
    filtered
  end
end
