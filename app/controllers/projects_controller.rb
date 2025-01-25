class ProjectsController < ApplicationController
  def index
    projects = Project.all

    # Фильтрация
    projects = ProjectFilterDecorator.new(projects).filter(params)
    
    # Пагинация
    paginated = paginate(projects)
    @projects = paginated[:records].map { |task| ProjectDecorator.new(task) }
    @current_page = paginated[:current_page]
    @total_pages = paginated[:total_pages]
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path, notice: 'Проект успешно создан.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to projects_path, notice: 'Проект успешно обновлён.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to projects_path, notice: 'Проект успешно удалён.'
    else
      redirect_to projects_path, alert: 'Не удалось удалить проект. Убедитесь, что нет связанных записей.'
    end
  rescue ActiveRecord::InvalidForeignKey => e
    redirect_to projects_path, alert: 'Ошибка: Невозможно удалить проект, так как существуют связанные записи.'
  end
  
  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
