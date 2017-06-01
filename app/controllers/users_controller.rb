class UsersController < ApplicationController

  before_action :get_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user #that email was already found in database
      # flash alert that user email is already in use
      flash[:alert] = "Error: User already exists with that email.  Check form or log in."
      redirect_to root_path
    else
      @user = User.new(user_params)
      if @user.save
        # user was successfully created so redirect to show page
        redirect_to @user
      else
        # show error and render signup page
        flash[:alert] = "Error: User not created"
        flash[:error] = @user.errors.full_messages.to_sentence
        render :new
      end

    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

  def get_user
    @user = User.find_by(id: params[:id])
  end
end
