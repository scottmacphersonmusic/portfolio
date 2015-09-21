class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

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
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      redirect_to @project, notice: 'Project successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = 'Project was successfully destroyed!'
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :technologies_used, :image_url)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
