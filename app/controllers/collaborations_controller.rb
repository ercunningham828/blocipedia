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

  def destroy
    @wiki=Wiki.where(slug:params[:id]).first
    @collaboration=Collaboration.where(user_id:params[:collaboration][:user_id]).where(wiki_id:@wiki.id).first
   
    
     if @collaboration.destroy
       flash[:notice] = "User was removed"
       redirect_to @wiki
     else
       flash[:error] = "There was an error removing the user."
       redirect_to @wiki
     end
  end

  private

  def collab_params
    params.require(:collaboration).permit(:user_id,:wiki_id)
  end
end
