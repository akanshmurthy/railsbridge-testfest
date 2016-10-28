Factory.define :user do |f|
  f.sequence(:email) { |n| "user@gmail.com" }
  f.password "shhhhhh!"
end
