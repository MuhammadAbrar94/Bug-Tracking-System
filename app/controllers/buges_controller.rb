class BugesController < ApplicationController
    load_and_authorize_resource
    def index
        @project = Project.find(params[:project_id])
        @buge = Buge.where(project_id: params[:project_id])

    end

    def new
        @buge = Buge.new
        @project = Project.find(params[:project_id])
    end

    def create
        @buge = Buge.new(buge_params)
        @project = Project.find(params[:buge][:project_id])

        @buge.project = @project
        if @buge.save
            flash[:success] = "Added #{@buge.title} to projects!"
            redirect_to buge_path(@buge)    
        else
            render 'new'
        end
    end

    def edit
        @buge = Buge.find(params[:id]) 
        @project = Project.find(params[:project_id])
       
    end

    def update
        @buge = Buge.find(params[:id])
        if @buge.update(buge_params)
            flash[:success] = "Added #{@buge.title} to projects!"
            redirect_to buge_path(@buge)    
        else
            render 'edit'
        end
    end

    def show
        @buge = Buge.find(params[:id])
    end

    def destroy
        Buge.find(params[:id]).destroy
        flash[:success] = "Bug deleted successfully"
        redirect_to buges_path
    end

    private
    
        def buge_params
            params.require(:buge).permit(:title, :description, :status, :deadline, :image, :typeBug)
        end
end
