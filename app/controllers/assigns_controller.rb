class AssignsController < ApplicationController
  
  load_and_authorize_resource
  
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

      def destroy
        Assign.find(params[:id]).destroy
        flash[:success] = "Assigne deleted successfully"
        assign = Assign.find(params[:id])
        project = params[:project_id] 
        redirect_to project_path(project)
    end
    def edit
      @project = Project.find(params[:project_id])
      
      assign_users = @project.assigns.pluck(:user_id)
      @users = User.where(role: [:developer, :qa]).where.not(id: assign_users)
      # @users = User.where(role: [:developer, :qa]).where.not(id: u)
    end
    def update
      @users = User.all
      @project = Project.find(params[:assign][:project_id])
        @assigns = []
            # loop through the selected user_ids to create new Assign records
            params[:user_ids].each do |user_id|
                user = User.find(user_id)
                assign = Assign.new(user: user, project: @project)
                @assigns << assign if assign.save
            end
            redirect_to project_path(@project)

      end
end