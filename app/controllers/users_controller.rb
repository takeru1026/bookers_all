class UsersController < ApplicationController
  def index
    @users= User.all
    @user= current_user
  end

  def show
    @user= User.find(params[:id])
    @book=Book.new
  end

  def edit
    @user=User.find(params[:id])
    @users= current_user
    if @user == @users

    else
      redirect_to user_path(@users.id)
    end

  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:success]="successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
