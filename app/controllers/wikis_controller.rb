class WikisController < ApplicationController
  def index
    @wikis=policy_scope(Wiki).paginate(page: params[:page], per_page: 10)
    @wiki=Wiki.new
  end

  def show
    @wiki=Wiki.where(slug:params[:id]).first
    @collaboration=Collaboration.new
    @collaborations=@wiki.collaborations
    @others=@wiki.collaborations.reject {|a| a.user==current_user}
    @users=User.all.reject {|a| a.wikis.include?(@wiki)}
  end

  def new
    @wiki=Wiki.new
    authorize @wiki
  end

  def create
    @wiki=Wiki.new(wiki_params)
    @collaboration=@wiki.collaborations.build(wiki:@wiki,user:current_user)
    authorize @wiki
    if @wiki.save
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :new
     end
  end

  def edit
    @wiki=Wiki.where(slug:params[:id]).first
    authorize @wiki
  end

  def update
    @wiki=Wiki.where(slug:params[:id]).first
    authorize @wiki
     if @wiki.update_attributes(wiki_params)
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :edit
     end
  end

 def destroy
     @wiki=Wiki.where(slug:params[:id]).first
     authorize @wiki

     if @wiki.destroy
       flash[:notice] = "Wiki was deleted successfully."
       redirect_to wikis_path
     else
       flash[:error] = "There was an error deleting the wiki."
       render :show
     end
   end
  private

  def wiki_params
    params.require(:wiki).permit(:title,:body,:private)
  end
end
