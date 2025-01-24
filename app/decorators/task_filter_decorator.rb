class TaskFilterDecorator
  def initialize(relation)
    @relation = relation
  end

  def filter(params)
    filtered = @relation
    filtered = filter_by_title(filtered, params[:title]) if params[:title].present?
    filtered = filter_by_status(filtered, params[:status]) if params[:status].present?
    filtered = filter_by_project(filtered, params[:project_id]) if params[:project_id].present?
    filtered = filter_by_assignee(filtered, params[:assignee_id]) if params[:assignee_id].present?
    filtered = order_by_due_date(filtered, params[:order]) if params[:order].present?
    filtered
  end

  private

  def filter_by_title(relation, title)
    relation.where("title ILIKE ?", "%#{title}%")
  end

  def filter_by_status(relation, status)
    relation.where(status: status)
  end

  def filter_by_project(relation, project_id)
    relation.where(project_id: project_id)
  end

  def filter_by_assignee(relation, assignee_id)
    relation.where(assignee_id: assignee_id)
  end

  def order_by_due_date(relation, order)
    order == "asc" ? relation.order(due_date: :asc) : relation.order(due_date: :desc)
  end
end
