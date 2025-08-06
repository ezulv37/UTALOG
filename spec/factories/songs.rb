FactoryBot.define do
  factory :song do
    association :user

    sequence(:title) { |n| "Test Song #{n}" }
    artist { "Test Artist" }
    genre { "J-POP" }
    key { 0 }
    memo { "これはテスト用のメモです。" }
  end
end
