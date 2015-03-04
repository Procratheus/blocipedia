class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(shared_params)
    if @collaborator.save
      flash[:notice] = "Collaborator was successfully added."
      redirect_to @wiki
    else
      flash[:error] = "There was an error adding the Collaborator"
      redirect_to @wiki
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @Collaborator = @wiki.collaborator.find(params[:user_id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator was successfully removed."
      redirect_to @wiki
    else
      flash[:error] = "There was an error removing the Collaborator"
      redirect_to @wiki
    end
  end

  protected

  def shared_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end

end
