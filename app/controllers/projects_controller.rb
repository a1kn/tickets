class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(strong_params)

    if @project.save
      flash[:success] = 'Project created.'
      redirect_to @project
    else
      render 'new'
    end
  end

  def show
    @project = find_project
    @tickets = Ticket.where('project_id = ?', params[:id])
  end

  def edit
    @project = find_project
  end

  def update
    @project = find_project

    if @project.update(strong_params)
      flash[:success] = 'Project updated.'
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project = find_project
    @project.destroy

    flash[:success] = 'Project was deleted.'
    redirect_to projects_path
  end

  private

  def strong_params
    params.require(:project).permit(:name, :description)
  end

  def find_project
    Project.find(params[:id])
  end
end
