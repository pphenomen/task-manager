class TaskFilterDecorator < BaseFilterDecorator
  def filter(params)
    filtered = data
    filtered = filter_by_field(filtered,'title', params[:title]) if params[:title].present?
    filtered = filter_by_status(filtered, params[:status]) if params[:status].present?
    filtered = filter_by_project(filtered, params[:project_id]) if params[:project_id].present?
    filtered = filter_by_assignee(filtered, params[:assignee_id]) if params[:assignee_id].present?
    filtered = order_by_due_date(filtered, params[:order]) if params[:order].present?
    filtered
  end

  private

  def filter_by_status(data, status)
    data.where(status: status)
  end

  def filter_by_project(data, project_id)
    data.where(project_id: project_id)
  end

  def filter_by_assignee(data, assignee_id)
    data.where(assignee_id: assignee_id)
  end

  def order_by_due_date(data, order)
    order == "asc" ? data.order(due_date: :asc) : data.order(due_date: :desc)
  end
end
