class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create ]
  before_action :if_not_admin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを作成しました！"
    else
      render :new
    end
  end

  def show
     @user = User.find(params[:id])
  end

  def index
    @users = User.all
    # @users = User.select(:name, :email, :id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'ユーザーを編集しました！'
      redirect_to  admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:admin, :name, :email, 
    :password, :password_confirmation)
  end

  def login_already
    if current_user
      flash[:notice]="ログイン中です"
      redirect_to user_path(current_user.id)
    end
  end

  def user_check
    if current_user.id != params[:id].to_i
      flash[:notice]="アクセス権限がありません"
      redirect_to user_path(current_user.id)
    end
  end

  def if_not_admin
    redirect_to tasks_path, notice: "管理者権限がありません。" unless admin_user?
  end

end
