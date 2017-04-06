FactoryGirl.define do

  # Sequences
  sequence :name do |n|
    "John Testerton no. #{n}"
  end

  sequence :email do |n|
    "person_#{n}@example.com"
  end


  # Tables
  factory :user do
    name
    email
    password              "foobarbaz"
    password_confirmation "foobarbaz"
  end

  factory :post do
    title "Example Post"
    body  "#Test post\nSome lines"
    user
  end

  factory :comment do
    name
    body "Test comment body"
    post
  end

  factory :subscriber do
    name
    email
  end
end
