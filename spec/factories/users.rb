# frozen_string_literal: true

FactoryBot.define do
  factory :valid_user, class: User do
    email { "valid@example.com" }
    password { "validvalid" }
    password_confirmation { "validvalid" }
  end

  factory :user_b, class: User do
    email { "user_b@example.com" }
    password { "useruser" }
    password_confirmation { "useruser" }
  end
end
