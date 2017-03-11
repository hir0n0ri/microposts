class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  
  def show # 追加
   @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
    redirect_to user_path(@user) , notice: '編集しました'
    else
    render 'edit'
    end
  end
  
  def index
  @users = User.page(params[:page]).per(50)
  end
end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :location, :password, :password_confirmation)
  end
  
  def set_user
  @user = User.find(params[:id])
  unless @user == current_user
  redirect_to root_path 
  end
end

 
