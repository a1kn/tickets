class ProjectsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @projects = Project.all

    first_run?
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

  def first_run?
    if Project.all.none?
      flash[:success] = 'Welcome to the Ticketing App! This app allows you to' +
        ' manage tickets by organizing them into projects and adding tags. ' +
        ' You will need to register for an account before getting started. ' +
        ' When you are logged in, create a new project and begin!'
    end
  end
end
