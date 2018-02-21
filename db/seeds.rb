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

users = User.order(:created_at).take(5)
10.times do |n|
  name = "topics-#{n+1}"
  users.each { |user| user.topics.create!(name: name) }
end

topics = Topic.order(:created_at).take(5)
10.times do |n|
  name = "lessons-#{n+1}"
  topics.each { |topic| topic.lessons.create!(name: name) }
end
