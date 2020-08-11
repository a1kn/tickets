class TagsController < ApplicationController
  before_action :require_login, except: [:index]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(strong_params)

    if @tag.save
      flash[:success] = 'Tag created.'
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def edit
    @tag = find_tag
  end

  def update
    @tag = find_tag

    if @tag.update(strong_params)
      flash[:success] = 'Tag updated.'
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  def destroy
    @tag = find_tag
    @tag.destroy

    flash[:success] = 'Tag was deleted.'
    redirect_to :back
  end

  private

  def strong_params
    params.require(:tag).permit(:name)
  end

  def find_tag
    Tag.find(params[:id])
  end
end
