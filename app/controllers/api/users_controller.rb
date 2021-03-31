class Api::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    render json: @user, serializer: UserSerializer
  end

  def avatar
    binding.pry
  end
  
  def all_users
    @users = User.all
    render json: @users, each_serializer: UserSerializer
  end

  def login_check
    if user_signed_in?
      render json: { login:'true' }
    end
  end

  def user_detail
    @user = current_user
    render json: @user, serializer: UserSerializer
  end
  
  def dep_users
    @users = User.where(department_main_id: current_user.department_main_id)
    render json: @users, each_serializer: UserSerializer
  end

end
