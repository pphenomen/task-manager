class TasksController < ApplicationController
  def index
    tasks = Task.all

    # Фильтрация
    tasks = tasks.where("title ILIKE ?", "%#{params[:title]}%") if params[:title].present?
    tasks = tasks.where(status: params[:status]) if params[:status].present?
    tasks = tasks.where(project_id: params[:project_id]) if params[:project_id].present?
    tasks = tasks.where(assignee_id: params[:assignee_id]) if params[:assignee_id].present?
    tasks = tasks.order(due_date: params[:order] == "asc" ? :asc : :desc) if params[:order].present?

    # Пагинация
    paginated = paginate(tasks, 5)
    @tasks = paginated[:records]
    @current_page = paginated[:current_page]
    @total_pages = paginated[:total_pages]
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'Задача успешно создана.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Задача успешно обновлена.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to projects_path, notice: 'Задача успешно удалена.'
    else
      redirect_to tasks_path, alert: 'Не удалось удалить задачу. Убедитесь, что нет связанных записей.'
    end
  rescue ActiveRecord::InvalidForeignKey => e
    redirect_to projects_path, alert: 'Ошибка: Невозможно удалить задачу, так как существуют связанные записи.'
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status, :project_id, :assignee_id)
  end
end
