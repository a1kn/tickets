class CommentsController < ApplicationController
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.create(strong_params)
    @comment.creator = User.find(session[:user_id])
    @comment.save
    update_ticket_status if params[:status]
    redirect_to ticket_path(@ticket)
  end

  def edit
    @ticket = Ticket.find(params[:ticket_id])
    @comment = Comment.find(params[:id])
    check_user
  end

  def update
    @ticket = Ticket.find(params[:ticket_id])
    @comment = Comment.find(params[:id])

    check_user

    update_ticket_status if params[:status]

    if @comment.update(strong_params)
      flash[:success] = 'Comment updated.'
      redirect_to ticket_path(@ticket)
    else
      flash[:warning] = 'Comment could not be updated.'
      redirect_to ticket_path(@ticket)
    end
  end

  def destroy
    @ticket = Ticket.find(params[:ticket_id])
    @comment = Comment.find(params[:id])

    check_user

    @comment.destroy

    flash[:success] = 'Comment was deleted.'
    redirect_to ticket_path(@ticket)
  end

  private

  def check_user 
    if @comment.creator.id != session[:user_id]
      redirect_to root_path
    end
  end

  def strong_params
    params.require(:comment).permit(:body)
  end

  def update_ticket_status
    if @ticket.update_attribute(:status, params[:status])
      flash[:success] = 'Status was updated.'
    else
      flash[:warning] = 'Status could not be updated.'
    end
  end
end
