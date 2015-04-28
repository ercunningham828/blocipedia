class ChargesController < ApplicationController
   def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.name}",
     amount: Amount.new.default,
     email: current_user.email,
   }
  end

  def create
     # Creates a Stripe Customer object, for associating
   # with the charge
   if current_user.customer_id
       customer=Stripe::Customer.retrieve(:id=>current_user.customer_id)
       card=customer.sources.create(card: params[:stripeToken])
   else
    card=params[:stripeToken]
     customer = Stripe::Customer.create(
         email: current_user.email,
         card: card
       )
     current_user.customer_id=customer.id
     current_user.save
   end

   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: Amount.new.default,
     description: "Premium Blocipedia Membership - #{current_user.email}",
     currency: 'usd',
   )
   flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
   current_user.update_attributes(role: "premium")
   redirect_to edit_user_registration_path # or wherever
 
 # Stripe will send back CardErrors, with friendly messages
 # when something goes wrong.
 # This `rescue block` catches and displays those errors.
 rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
  end
end
