class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  # TODO: Create profile view with set timezone
  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Updated successfully'
      redirect_to edit_user_path
    else
      render :edit
    end
  end

  private

  def find_user
    @user = current_user
    @user.create_profile unless @user.profile
  end

  def user_params
    params.require(:user).permit(:time_zone, profile_attributes: [:id, :birthday, :display_name, :location, :bio])
  end
end
