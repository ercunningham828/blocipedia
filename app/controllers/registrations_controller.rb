class RegistrationsController < Devise::RegistrationsController
 before_filter :stripe_btn_data, only: [:new, :edit]

 def stripe_btn_data
  @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Blocipedia Premium Membership- #{current_user.name}",
     amount: Amount.new.default,
     email: current_user.email,
   }
 end

 
end