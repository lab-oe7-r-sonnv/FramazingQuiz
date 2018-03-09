User.create! name: "Nguyen Van Son", email: "a1@gmail.com",
  type: "Admin", password: "123456", password_confirmation: "123456",
  confirmed_at: Time.now.utc

10.times do |n|
  name  = Faker::Name.name
  email = "teacher-#{n + 1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, type: "Teacher", password: password,
    password_confirmation: password, confirmed_at: Time.now.utc
end

10.times do |n|
  name  = Faker::Name.name
  email = "student-#{n + 1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, type: "Student", password: password,
    password_confirmation: password, confirmed_at: Time.now.utc
end

users = User.order(:created_at).take(10)
3.times do |n|
  name = "lesson-#{n+1}"
  users.each {|user| user.lessons.create!(name: name)}
end

Lesson.all.each_with_index do |lesson, lesson_idx|
  7.times do |idx|
    word = "word-#{(lesson_idx + 1) * (idx + 1) + 1}"
    definition = "def-#{(lesson_idx + 1) * (idx + 1) + 1}"
    lesson.words.create! text: word
    lesson.words.last.definitions.create! text: definition, correct: true
  end
end
