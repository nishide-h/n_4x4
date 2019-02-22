FactoryBot.define do
  factory :valid_user, class: User do
    email { "valid@example.com" }
    password { "validvalid" }
    password_confirmation { "validvalid" }
  end
end

