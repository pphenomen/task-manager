class UsersController < ApplicationController
  def index
    users = User.all
    
    # Фильтрация
    users = UserFilterDecorator.new(users).filter(params)

    # Пагинация
    paginated = paginate(users, 5)
    @users = paginated[:records]
    @current_page = paginated[:current_page]
    @total_pages = paginated[:total_pages]
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'Пользователь успешно создан.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'Пользователь успешно обновлён.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, notice: 'Пользователь успешно удалён.'
    else 
      redirect_to projects_path, alert: 'Не удалось удалить пользователя. Убедитесь, что нет связанных записей.'
    end
  rescue ActiveRecord::InvalidForeignKey => e
    redirect_to projects_path, alert: 'Ошибка: Невозможно удалить пользователя, так как существуют связанные записи.'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
