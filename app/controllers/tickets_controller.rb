class TicketsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @tickets = Ticket.all
    @tickets = @tickets.filter_by_project(params[:project]) if params[:project].present?
    @tickets = @tickets.filter_by_status(params[:status]) if params[:status].present?
    @tickets = @tickets.filter_by_tag(params[:tag]) if params[:tag].present?
    @projects = Project.all
    @tags = Tag.all.sort_by {|t| t.name}
  end

  def new
    @ticket = Ticket.new
    @projects = Project.all
    @tags = Tag.all.sort_by {|t| t.name}
    @users = User.all

    check_for_existing_projects
  end

  def create
    @ticket = Ticket.new(strong_params)
    @projects = Project.all
    @tags = Tag.all.sort_by {|t| t.name}
    @users = User.all
    @ticket.creator = User.find(session[:user_id]) 
    add_tags if params[:tags]

    if @ticket.save
      flash[:success] = 'Ticket created.'
      redirect_to @ticket
    else
      render 'new'
    end
  end

  def show
    @ticket = find_ticket
    @comment = Comment.new
  end

  def edit
    @ticket = find_ticket
    @tags = Tag.all.sort_by {|t| t.name}
    @projects = Project.all
    @users = User.all
  end

  def update
    @ticket = find_ticket
    @projects = Project.all
    @tags = Tag.all.sort_by {|t| t.name}
    @users = User.all
    add_tags if params[:tags]

    if @ticket.update(strong_params)
      flash[:success] = 'Ticket updated.'
      redirect_to @ticket
    else
      render 'edit'
    end
  end

  def destroy
    @ticket = find_ticket
    @ticket.destroy

    flash[:success] = 'Ticket was deleted.'
    redirect_to tickets_path
  end

  private 

  def strong_params
    params.require(:ticket).permit(:project_id, :name, :description, :body, :status, :assignee_id)
  end

  def find_ticket
    Ticket.find(params[:id])
  end

  def add_tags
    tags = params[:tags].map {|tag_id| Tag.find(tag_id)}
    @ticket.tags = tags
  end

  def check_for_existing_projects
    if Project.all.none?
      flash[:warning] = 'You must create a project before creating a ticket.'
      redirect_to new_project_path
    end
  end
end
