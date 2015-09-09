class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = "Project successfully created!"
      redirect_to @project
    else
      flash.now[:error] = "There was a problem saving your project!"
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(project_params)
      redirect_to @project, notice: 'Project successfully updated!'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :technologies_used)
  end
end
