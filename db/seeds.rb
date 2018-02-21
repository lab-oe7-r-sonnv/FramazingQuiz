# Users
User.create! name: "Example User", email: "example@railstutorial.org",
  type: "Teacher", password: "foobar", password_confirmation: "foobar"

type = %w(Teacher Student)
type.each do |t|
  20.times do |n|
    name  = Faker::Name.name
    email = "example-#{n + 1}@railstutorial.org"
    password = "password"
    User.create! name: name, email: email, type: t, password: password,
      password_confirmation: password
  end
end

# Topics
User.first.topics.create! name: "Temporary"

# Lessons
topic = Topic.first
60.times do
  title = Faker::Name.title
  topic.lessons.create! name: title
end
