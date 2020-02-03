FactoryBot.define do
  factory :article do
    title { "テストを書く" }
    description { "RSpec & Capybara & FactoryBot" }
    user
  end
end