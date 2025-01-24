class ProjectsController < ApplicationController
  def index
    projects = Project.all

    # Фильтрация
    projects = projects.where("title ILIKE ?", "%#{params[:title]}%") if params[:title].present?
    
    # Пагинация
    paginated = paginate(projects, 5)
    @projects = paginated[:records]
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
      redirect_to projects_path
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
      redirect_to projects_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end
  
  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
