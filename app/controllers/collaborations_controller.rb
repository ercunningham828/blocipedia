class CollaborationsController < ApplicationController
  def create
    @collaboration=Collaboration.new(collab_params)
     @wiki=Wiki.find(params[:collaboration][:wiki_id])
     @user=User.find(params[:collaboration][:user_id])
    if @wiki.users.include?(@user)
      redirect_to @collaboration.wiki
       flash[:notice] = "User is already a collaborator."
     elsif @collaboration.save
       flash[:notice] = "User has been added as a collaborator."
       redirect_to @collaboration.wiki
     else
      redirect_to @collaboration.wiki
       flash[:error] = "There was an error adding the user. Please try again."
     end
  end

  private

  def collab_params
    params.require(:collaboration).permit(:user_id,:wiki_id)
  end
end
