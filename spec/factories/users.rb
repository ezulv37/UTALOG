FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }

    after(:create) do |user|
      user.image.attach(
        io: Rails.root.join('spec/fixtures/images/test_icon_image.png').open,
        filename: 'test_icon_image.png',
        content_type: 'image/png'
      )
    end
  end
end
