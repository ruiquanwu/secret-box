 require 'faker'

 # Create Users
 5.times do
   user = User.new(
     name:     Faker::Name.name,
     email:    Faker::Internet.email,
     password: Faker::Lorem.characters(10)
   )
   user.skip_confirmation!
   user.save!
 end
 users = User.all

# Create Diaries
 50.times do
   Diary.create!(
     user:   users.sample,
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph
   )
 end
diaries = Diary.all

 user = User.first
 user.skip_reconfirmation!
 user.update_attributes!(
   email: 'ruiquanwu@gmail.com',
   password: '123456abc'
 )

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Diary.count} posts created"
