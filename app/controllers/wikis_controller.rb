class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  def index
    @wiki = Wiki.all
  end

  def show
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    if @wiki.save
      flash[:notice] = "Your #{@wiki.title} Wiki was successfully created."
      redirect_to @wiki
    else
      flash[:error] = "Your Wiki was not created. Please try again."
      redirect_to :new
    end
  end

  def edit
  end

  def update
    @wiki.update(wiki_params)
    if @wiki.update
      flash[:notice] = "Your #{@wiki.title} Wiki was successfully updated."
      redirect_to @wiki
    else
      flash[:error] = "Your #{@wiki.title} Wiki was not successfully updated. Please try again."
      redirect_to :edit
    end
  end

  def destroy
    if @wiki.destroy
      flash[:notice] = "Your #{@wiki.title} Wiki was deleted."
      redirect_to :index
    else
      flash[:error] = "Your #{@wiki.title} Wiki was not deleted. Please try again."
    end
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:id])
  end

  def wiki_params
    params.require(:wiki).permit(:title, :description, :body)
  end

end
