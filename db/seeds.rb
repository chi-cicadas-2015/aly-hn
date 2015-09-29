require 'faker'

5.times do |num|
  User.create!(email: "email#{num}.email.com",
               first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               password: "123")
end

User.all.each do |user|
  3.times do
    post = user.posts.create!(title: Faker::Hacker.abbreviation, body: Faker::Lorem.paragraph)

    3.times do
      post.comments.create!(text: Faker::Hacker.say_something_smart, commenter: User.all.sample)
    end
  end
end
