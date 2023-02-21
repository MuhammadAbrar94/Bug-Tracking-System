class ProjectsController < ApplicationController
    def index
        @project = Project.all
    end

    def new
        @project = Project.new
    end
    def create
        @project = Project.new(project_params)
        if @project.save
          flash[:success] = "Added #{@project.title} to projects!"
          redirect_to project_path(@project)
        else
          render 'new'
        end
      end
      

    def edit
        @project = Project.find(params[:id])
    end
    def update
        @project = Project.find(params[:id])
        if @project.update(project_params)
            flash[:success] = "Your project was updated successfully"
            redirect_to @project
        else
            render 'edit'
        end 
    end

    def show
        @project = Project.find(params[:id])
    end

end
