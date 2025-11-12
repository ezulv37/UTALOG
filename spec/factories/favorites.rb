FactoryBot.define do
  factory :favorite do
    association :user
    association :song
  end
end
