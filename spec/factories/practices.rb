FactoryBot.define do
  factory :practice do
    association :user

    sequence(:title) { |n| "テスト用練習曲#{n}" }
    artist { "テスト用練習アーティスト" }
    key { 0 }
    comment { "これはテスト用のコメントです。" }
    score { 85 }

    after(:build) do |practice|
      practice.result_image1.attach(
        io: Rails.root.join('spec/fixtures/images/test_result_image1.png').open,
        filename: 'est_result_image1.png',
        content_type: 'image/png'
      )

      practice.result_image2.attach(
        io: Rails.root.join('spec/fixtures/images/test_result_image2.png').open,
        filename: 'est_result_image2.png',
        content_type: 'image/png'
      )
    end
  end
end
