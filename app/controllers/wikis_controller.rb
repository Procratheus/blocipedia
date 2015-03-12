class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  def index
    @public_wikis = Wiki.publicly_viewable(current_user)
    @private_wikis = Wiki.privately_viewable(current_user)
    @collaborated_wikis = current_user.shared_wikis
    authorize @public_wikis
    authorize @private_wikis
    authorize @collaborated_wikis
  end

  def show
    @users = User.where.not(id: current_user.id).where(role: "premium")
  end

  def new
    @wiki = current_user.wikis.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Your #{@wiki.title} Wiki was successfully created."
      redirect_to wikis_path
    else
      flash[:error] = "Your Wiki was not created. Please try again."
      redirect_to :new
    end
  end

  def edit
    authorize @wiki
  end

  def update
    @wiki.update(wiki_params)
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Your #{@wiki.title} Wiki was successfully updated."
      redirect_to @wiki
    else
      flash[:error] = "Your #{@wiki.title} Wiki was not successfully updated. Please try again."
      redirect_to :edit
    end
  end

  def destroy
    authorize @wiki
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
    params.require(:wiki).permit(:title, :description, :body, :private)
  end

end
