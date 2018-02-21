User.create! name: "Example User", email: "example@railstutorial.org",
  type: "Teacher", password: "foobar", password_confirmation: "foobar"

20.times do |n|
  name  = Faker::Name.name
  email = "teacher-#{n + 1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, type: "Teacher", password: password,
    password_confirmation: password
end

20.times do |n|
  name  = Faker::Name.name
  email = "student-#{n + 1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, type: "Student", password: password,
    password_confirmation: password
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

lessons = Lesson.order(:created_at).take 10
lessons.each_with_index do |lesson, lesson_idx|
  10.times do |idx|
    word = "word-#{(lesson_idx + 1) * (idx + 1) + 1}"
    definition = "def-#{(lesson_idx + 1) * (idx + 1) + 1}"
    lesson.words.create! text: word
    lesson.words.last.definitions.create! text: definition, correct: true
  end
end
