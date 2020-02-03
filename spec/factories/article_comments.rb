FactoryBot.define do
  factory :article_comment do
    content { "テストコメント" }
    article
    user
  end
end