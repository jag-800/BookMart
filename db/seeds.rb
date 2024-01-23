# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)





Admin.create!(email: 'a@a', password: 'aaaaaa')

Customer.create!(
  [
    {
      nick_name: "みっちー",
      full_name: "令和道子",
      full_name_kana: "レイワミチコ",
      department: 1,
      grade: 4,
      email: "0@0",
      phone_number: "00022224353",
      is_active: true,
      password: "000000",
    },
    {
      nick_name: "ナンバ",
      full_name: "難波専太",
      full_name_kana: "ナンバセンタ",
      department: 2,  # 例: 法学部
      grade: 2,       # 例: 2年生
      email: "1@1",
      phone_number: "00088889999",
      is_active: false,
      password: "111111",
    },
    {
      nick_name: "にこにこ",
      full_name: "六本木一",
      full_name_kana: "ロッポンギハジメ",
      department: 8,
      grade: 3,
      email: "2@2",
      phone_number: "09177772222",
      is_active: true,
      password: "222222",
    },
    {
      nick_name: "おがちゃん",
      full_name: "尾形隆弘",
      full_name_kana: "オガタタカヒロ",
      department: 4,
      grade: 1,
      email: "3@3",
      phone_number: "09177773333",
      is_active: true,
      password: "333333",
    }
  ]
)

items = Item.create!(
  [
    {
      customer_id: "3",
      name: "実験ミクロ経済学",
      introduction: "ミクロ経済学の講義で使用したモノ",
      price: "300",
      is_active: "true",
    },
    {
      customer_id: "4",
      name: "キタミ式基本情報技術者",
      introduction: "イラストが多く、基本技情報技術者の資格に一番向いていると思われる",
      price: "300",
      is_active: "true",
    },
    {
      customer_id: "1",
      name: "ロールプレイで学ぶ韓国語",
      introduction: "韓国語コミュニケーションで使用、書き込み多数",
      price: "300",
      is_active: "true",
    },
    {
      customer_id: "3",
      name: "入門ミクロ経済学",
      introduction: "ミクロ経済学の講義で使用したもの",
      price: "300",
      is_active: "true",
    },
    {
      customer_id: "2",
      name: "世界一わかりやすい TOEICテストの英単語",
      introduction: "TOEIC頻出の英単語を出る順で学べる、言葉の成り立ちもあるので覚えやすい！",
      price: "300",
      is_active: "true",
    },
    {
      customer_id: "3",
      name: "簿記学",
      introduction: "簿記３級の範囲",
      price: "300",
      is_active: "true",
    },
    {
      customer_id: "4",
      name: "ITパスポート",
      introduction: "ITパスポートの資格におすすめ",
      price: "300",
      is_active: "true",
    },
    {
      customer_id: "4",
      name: "MOS Excel 365&2019 対策テキスト&問題集",
      introduction: "MOS EXcelの資格勉強に使いました",
      price: "300",
      is_active: "true",
    },
  ]
)


item_images = [
  Rails.root.join("app/assets/images/economics_blue.jpg"),
  Rails.root.join("app/assets/images/it_info.jpg"),
  Rails.root.join("app/assets/images/korean.jpg"),
  Rails.root.join("app/assets/images/economics_yellow.jpg"),
  Rails.root.join("app/assets/images/english_seki.jpg"),
  Rails.root.join("app/assets/images/accounting.jpg"),
  Rails.root.join("app/assets/images/it_passport.jpg"),
  Rails.root.join("app/assets/images/mos_excel.jpg"),
]

item_tags = [
  ["経済学","ミクロ","入門"],
  ["情報学","資格","入門"],
  ["韓国語","初級","入門"],
  ["経済学","ミクロ","入門"],
  ["英語","単語"],
  ["簿記","初級","会計学"],
  ["情報学","資格","入門"],
  ["情報学","MOS","問題集","入門","資格"],
]

# 各アイテムに画像とタグを追加
items.each_with_index do |item, index|
  # 画像をアタッチする（ActiveStorageの場合）
  image_path = item_images[index]

  if File.exist?(image_path)
    item.item_image.attach(io: File.open(image_path), filename: File.basename(image_path), content_type: 'image/jpeg')
  else
    Rails.logger.warn "画像ファイルが見つかりません: #{image_path}"
  end

  # タグを追加する（acts-as-taggable-onの場合）
  item_tags[index].each { |tag| item.tag_list.add(tag) }
  item.save
end
