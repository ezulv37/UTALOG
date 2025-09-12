# 既存データの削除
puts "既存データを削除中..."
User.destroy_all
Song.destroy_all
Practice.destroy_all
puts "削除完了"

# ユーザー作成
puts "ユーザーを作成中..."
user1 = User.create!(
  name: "demo_user1",
  email: "demo_user1@example.com",
  password: "password",
  password_confirmation: "password"
)
user1.image.attach(io: File.open(Rails.root.join('db/seed_images', 'user_icon_sample1.jpg')), filename: 'user_icon_sample1.jpg')

user2 = User.create!(
  name: "demo_user2",
  email: "demo_user2@example.com",
  password: "password",
  password_confirmation: "password"
)
user2.image.attach(io: File.open(Rails.root.join('db/seed_images', 'user_icon_sample2.jpg')), filename: 'user_icon_sample2.jpg')

user3 = User.create!(
  name: "demo_user3",
  email: "demo_user3@example.com",
  password: "password",
  password_confirmation: "password"
)

users = [user1, user2, user3]
puts "ユーザー作成完了"

# ユーザーごとの曲データ
songs_data = [
  [
    {title: "Shiny Day", artist: "A Band", genre: "J-POP", key: 0, memo: "楽しい曲"},
    {title: "Rocking Night", artist: "B Group", genre: "ロック", key: -2, memo: "盛り上がる曲"},
    {title: "Anime Dream", artist: "C Band", genre: "アニメ・ボカロ", key: 1, memo: "練習用"}
  ],
  [
    {title: "Sunny Morning", artist: "A Band", genre: "J-POP", key: 1, memo: "爽やか"},
    {title: "Hard Rock", artist: "B Group", genre: "ロック", key: -3, memo: "元気が出る"},
    {title: "Vocaloid Song", artist: "C Band", genre: "アニメ・ボカロ", key: 2, memo: "練習曲"}
  ],
  [
    {title: "Calm Evening", artist: "A Band", genre: "バラード", key: 0, memo: "落ち着く"},
    {title: "Epic Journey", artist: "B Group", genre: "ロック", key: 4, memo: "力強い曲"},
    {title: "Fantasy Tune", artist: "C Band", genre: "アニメ・ボカロ", key: -3, memo: "練習用"}
  ]
]

# ユーザーごとの練習ログデータ
practices_data = [
  [ # user1
    {title: "Shiny Day", artist: "A Band", key: 0, score: 80, comment: "テンポ良く歌えた", images: ['result_sample1.jpg','result_sample2.jpg']},
    {title: "Rocking Night", artist: "B Group", key: -2, score: 75, comment: "サビが難しかった"},
    {title: "Sunset Melody", artist: "C Band", key: 2, score: 85, comment: "最後まで安定して歌えた", images: ['result_sample3.jpg','result_sample4.jpg']}
  ],
  [ # user2
    {title: "Sunny Morning", artist: "A Band", key: 1, score: 85, comment: "リズムが安定した", images: ['result_sample1.jpg','result_sample2.jpg']},
    {title: "Hard Rock", artist: "B Group", key: -3, score: 70, comment: "声が疲れた"},
    {title: "Morning Light", artist: "C Band", key: 0, score: 90, comment: "滑らかに歌えた", images: ['result_sample3.jpg','result_sample4.jpg']}
  ],
  [ # user3
    {title: "Calm Evening", artist: "A Band", key: 0, score: 90, comment: "スムーズに歌えた", images: ['result_sample1.jpg','result_sample2.jpg']},
    {title: "Epic Journey", artist: "B Group", key: 4, score: 65, comment: "高音が難しい"},
    {title: "Night Sky", artist: "C Band", key: -1, score: 80, comment: "息継ぎがうまくできた", images: ['result_sample3.jpg','result_sample4.jpg']}
  ]
]

# レパートリー・練習ログ作成
users.each_with_index do |user, i|
  # レパートリー
  songs_data[i].each do |song|
    user.songs.create!(song)
  end

  # 練習ログ
  practices_data[i].each do |practice|
    p = user.practices.create!(
      title: practice[:title],
      artist: practice[:artist],
      key: practice[:key],
      score: practice[:score],
      comment: practice[:comment]
    )

    # imagesがある場合のみ添付
    if practice[:images]
      p.result_image1.attach(
        io: File.open(Rails.root.join('db/seed_images', practice[:images][0])),
        filename: practice[:images][0]
      )
      p.result_image2.attach(
        io: File.open(Rails.root.join('db/seed_images', practice[:images][1])),
        filename: practice[:images][1]
      )
    end
  end
end

puts "Seedデータの作成が完了しました"
