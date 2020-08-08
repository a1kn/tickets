class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def new
    @projects = Project.all
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(strong_params)
    @projects = Project.all

    if @ticket.save
      flash[:success] = 'Ticket created.'
      redirect_to @ticket
    else
      render 'new'
    end
  end

  def show
    @ticket = find_ticket
  end

  def edit
    @ticket = find_ticket
    @projects = Project.all
  end

  def update
    @ticket = find_ticket
    @projects = Project.all

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
    params.require(:ticket).permit(:project_id, :name, :description, :body, :status)
  end

  def find_ticket
    Ticket.find(params[:id])
  end
end
