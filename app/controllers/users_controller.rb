class UsersController < ApplicationController
  def new
    @user = User.new
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      redirect_to user_path(@user.id)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id unless current_user
      @user = User.find_by(id: session[:user_id])
      redirect_to user_path(current_user)
      flash[:notice] = "ユーザー登録が完了しました"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
