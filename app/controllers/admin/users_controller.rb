class Admin::UsersController < ApplicationController
  before_action :admin_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    # @users = User.all
    @users = User.select(:name, :email, :id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'ユーザーを編集しました！'
    else
      render :edit
    end
  end

  def destroy
  @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def login_already
    if current_user
      flash[:notice]="ログイン中です"
      redirect_to user_path(current_user.id)
    end
  end

  def user_check
    if current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to user_path(current_user.id)
    end
  end

  def admin_user
    redirect_to user_path(current_user.id) unless current_user.admin?
  end
end
