class UsersController < ApplicationController
  def index
    users = User.all
    
    # Фильтрация
    users = users.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?

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
      redirect_to users_path
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
      redirect_to users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def filter_params
    params.permit(:name)
  end
end
