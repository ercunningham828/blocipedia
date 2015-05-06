class UsersController < ApplicationController
  def update
    if current_user.update_attributes(user_params)
       flash[:notice] = "User information updated"
       redirect_to edit_user_registration_path
     else
       flash[:error] = "Invalid user information"
       redirect_to edit_user_registration_path
     end
  end

  def show
    @user=User.find(params[:id])
    @subscription=Subscription.new
   end

  def downgrade
      wikis=current_user.wikis
      wikis.each do |wiki|
        wiki.private=false
        wiki.save
      end
  
      
      current_user.role="standard"
      current_user.save
      redirect_to edit_user_registration_path

      customer=Stripe::Customer.retrieve(:id=>current_user.customer_id)
      ch=customer.charges.all(:limit=>1)

      refund = ch.first.refund
      flash[:success] = "Your account has been downgraded to a standard user."
    end

   private
 
   def user_params
     params.require(:user).permit(:name, :email_favorites)
   end
end
