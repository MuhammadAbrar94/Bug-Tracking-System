class AssignsController < ApplicationController

    def index
        @assign = assign.all
    end
      
    def new
        @project = Project.find(params[:project_id])
        @users = User.where(role: :developer).or(User.where(role: :qa))
    end

    def create
        @project = Project.find(params[:project_id])
        @assigns = []
        
        # loop through the selected user_ids to create new Assign records
        params[:user_ids].each do |user_id|
          user = User.find(user_id)
          assign = Assign.new(user: user, project: @project)
          @assigns << assign if assign.save
        end
        
        if @assigns.any?
          flash[:success] = "Assigned developers and QAs to project!"
          redirect_to project_path(@project)
        else
          flash[:error] = "Failed to assign developers and QAs to project."
          render 'new'
        end
      end
      
    
end