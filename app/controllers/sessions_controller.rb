class SessionsController < ApplicationController
  # skip_before_action :login_required, only: [:new, :create ]
  
  def new

  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:ssesion][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
end
