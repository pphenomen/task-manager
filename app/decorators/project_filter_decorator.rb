class ProjectFilterDecorator
  def initialize(relation)
    @relation = relation
  end

  def filter(params)
    filtered = @relation
    filtered = filter_by_title(filtered, params[:title]) if params[:title].present?
    filtered
  end

  private

  def filter_by_title(relation, title)
    relation.where("title ILIKE ?", "%#{title}%")
  end
end
