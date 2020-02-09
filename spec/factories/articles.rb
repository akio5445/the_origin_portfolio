FactoryBot.define do
  factory :article do
    title { "テストを書く" }
    description { "テスト本文" }
    user

    trait :invalid do
      title nil
      description nil
    end
  end

  factory :article_A, class: Article do
    title { "テストを書くA" }
    description { "テスト本文A" }
    user
  end

  factory :article_B, class: Article do
    title { "テストを書くB" }
    description { "テスト本文B" }
    user
  end
end