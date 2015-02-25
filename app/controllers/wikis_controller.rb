class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  def index
    @wikis = Wiki.all
    @user_public_wikis = @wikis.where(user_id: current_user.id)
    @user_private_wikis = @wikis.where(user_id: current_user.id)
    authorize @wikis
  end

  def show
  end

  def new
    @user_public_wiki = Wiki.new
    @user_private_wiki = Wiki.new
  end

  def create
    @user_public_wiki = current_user.wikis.build(wiki_params)
    @user_private_wiki = current_user.wikis.build(wiki_params)
    authorize @user_private_wiki
    if @user_public_wiki.save || @user_private_wiki.save
      flash[:notice] = "Your #{@wiki.title} Wiki was successfully created."
      redirect_to wikis_path
    else
      flash[:error] = "Your Wiki was not created. Please try again."
      redirect_to :new
    end
  end

  def edit
  end

  def update
    @wiki.update(wiki_params)
    if @wiki.save
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
      redirect_to wikis_path
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
