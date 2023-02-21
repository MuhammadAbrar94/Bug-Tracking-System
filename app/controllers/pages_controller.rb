class PagesController < ApplicationController
    def home
        if current_user
            @user = current_user
            @projects = @user.managed_projects
        end
    end
end

