# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(name: 'misaki', email: 'misaki@gmail.com', 
#             password: 'misaki', password_confirmation: 'misaki')

# User.create(name: 'karinuts', email: 'karinuts@gmail.com', 
#             password: 'karinuts', password_confirmation: 'karinuts', admin: true)

# <userデータ>
 User.create(name: 'seed1', email: 'seed1@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
 User.create(name: 'seed2', email: 'seed2@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
 User.create(name: 'seed3', email: 'seed3@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
 User.create(name: 'seed4', email: 'seed4@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
 User.create(name: 'seed5', email: 'seed5@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
 User.create(name: 'seed6', email: 'seed6@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
 User.create(name: 'seed7', email: 'seed7@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
 User.create(name: 'seed8', email: 'seed8@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
 User.create(name: 'seed9', email: 'seed9@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
 User.create(name: 'seed10', email: 'seed10@gmail.com', password: 'seed1@gmail.com', password_confirmation: 'seed1@gmail.com')
 
# <taskデータ>
10.times do |i|
  Task.create!(title: "タイトル", content: "友達と遊ぶ", user_id: 1)
end

# <labelデータ>
10.times do |i|
  Task.create!(label_name: "LABEL")
end
