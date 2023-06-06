class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  def index
    begin
      @users = User.all
      render json: @users
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end
  
  def show
    if @user.nil?
      render json: { error: 'User not found' }, status: :not_found
    else
      render json: @user
    end
  end  

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end  

  def destroy
    @user.destroy
    render json: { message: 'User successfully deleted' }, status: :ok
  end

  private

  def find_user
    @user = User.find_by(username: params[:_username])
  
    head :not_found if @user.nil?
  end  

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation)
  end
end

