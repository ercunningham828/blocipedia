require 'faker'
  
  # Create an admin user
 admin = User.new(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
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

 users=User.all

 30.times do
   Wiki.create!(
     user: users.sample,
     title: (Faker::Lorem.words(3).map {|word| word.capitalize}).join(' '),
     body:  Faker::Lorem.paragraph,
     private: false
   )
 end
 wikis = Wiki.all

 puts "Admin and Emily created"
 puts "#{Wiki.count} wikis created"