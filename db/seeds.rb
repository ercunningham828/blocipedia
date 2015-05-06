require 'faker'
  
  # Create an admin user
 admin = User.new(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role: 'admin',
 )
 admin.skip_confirmation!
 admin.save!

 emily = User.new(
   name:     'Emily',
   email:    'emily@example.com',
   password: 'helloworld',
 )
 emily.skip_confirmation!
 emily.save!

 premium= User.new(
   name:     'Premium User',
   email:    'premium@example.com',
   password: 'helloworld',
   role: 'premium',
   customer_id:  "cus_68zL9a8CwjEZE1",
 )
 premium.skip_confirmation!
 charge = Stripe::Charge.create(
     customer: "cus_68zL9a8CwjEZE1",
     amount: Amount.new.default,
     description: "Premium Blocipedia Membership - #{premium.email}",
     currency: 'usd',
   )
  premium.save!

 users=User.all

 30.times do
  wiki=Wiki.create!(
     title: (Faker::Lorem.words(3).map {|word| word.capitalize}).join(' '),
     body:  Faker::Lorem.paragraph,
     private: false
   )
  wiki.collaborations.create(user:users.sample)
 end
 wikis = Wiki.all




 puts "Admin and Emily created"
 puts "#{Wiki.count} wikis created"