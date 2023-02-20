class UsersController < ApplicationController
    def user_params
        params.require(:user).permit(:role, :email, :password, :password_confirmation, :remember_me)
      end
end