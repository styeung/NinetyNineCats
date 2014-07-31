class SessionsController < ApplicationController
  before_action :require_signed_out!, only: [:new, :create]
  before_action :require_signed_in!, only: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
    user_params[:user_name],
    user_params[:password]
    )

    if @user
      sign_in(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
