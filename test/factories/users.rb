FactoryBot.define do
  factory :user do
    name "MyString"
    email "MyString"
    gender "MyString"
    password_digest "MyString"
    activation_digest "MyString"
    remember_digest "MyString"
    reset_digest "MyString"
    activated_account false
    activated_account_at "2018-02-14 21:18:15"
    reset_sent_at "2018-02-14 21:18:15"
    blocked_activity false
  end
end
