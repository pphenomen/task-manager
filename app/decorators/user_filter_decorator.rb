class UserFilterDecorator
  def initialize(relation)
    @relation = relation
  end

  def filter(params)
    filtered = @relation
    filtered = filter_by_name(filtered, params[:name]) if params[:name].present?
    filtered
  end

  private

  def filter_by_name(relation, name)
    relation.where("name ILIKE ?", "%#{name}%")
  end
end
