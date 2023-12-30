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
      first_name: "令和",
      last_name: "道子",
      first_name_kana: "レイワ",
      last_name_kana: "ミチコ",
      email: "sample@example.com",
      post_code: "9995555",
      address: "東京都渋谷区神園町0-0",
      phone_number: "00022224353",
      is_active: true,
      password: "password",
    },
    {
      first_name: "難波",
      last_name: "専太",
      first_name_kana: "ナンバ",
      last_name_kana: "センタ",
      email: "0@0",
      post_code: "5420076",
      address: "大阪府大阪市中央区難波4-4-4 難波御堂筋センタービル 8階",
      phone_number: "00088889999",
      is_active: true,
      password: "000000",
    },
    {
      first_name: "六本木",
      last_name: "一",
      first_name_kana: "ロッポンギ",
      last_name_kana: "ハジメ",
      email: "1@1",
      post_code: "1066223",
      address: "東京都港区六本木3-2-1 住友不動産六本木グランドタワー 23F",
      phone_number: "09177772222",
      is_active: false,
      password: "111111",
    }
  ]
)

Item.create!(
  [
    {
      customer_id: "1",
      name: "プロを目指す人のためのRuby入門",
      introduction: "言語仕様からテスト駆動開発・デバッグ技法まで",
      price: "2900",
      is_active: "true",
    },
    {
      customer_id: "1",
      name: "	独習Python",
      introduction: "手を動かしておぼえるPythonプログラミング ――独学に最適な“標準教科書”",
      price: "1650",
      is_active: "true",
    },
    {
      customer_id: "2",
      name: "	To LOVEる -とらぶる- (3)",
      introduction: "めちゃくちゃえろです",
      price: "4545",
      is_active: "true",
    },
    {
      customer_id: "2",
      name: "ONE PIECE モノクロ版 1",
      introduction: "時は大海賊時代。いまや伝説の海賊王G・ロジャーの遺した『ひとつなぎの大秘宝』を巡って、幾人もの海賊達が戦っていた",
      price: "460",
      is_active: "true",
    },
    {
      customer_id: "3",
      name: "1冊ですべて身につくHTML & CSSとWebデザイン入門講座",
      introduction: "ずっと、一番売れているHTML本!大反響! 32刷突破！",
      price: "2486",
      is_active: "true",
    },
    {
      customer_id: "3",
      name: "ゼロからわかる Ruby 超入門",
      introduction: "かんたんIT基礎講座",
      price: "2728",
      is_active: "true",
    },
  ]
)


item_images = [
  Rails.root.join("app/assets/images/ruby_.jpg"),
  Rails.root.join("app/assets/images/python_.jpg"),
  Rails.root.join("app/assets/images/tloveる_.jpg"),
  Rails.root.join("app/assets/images/onepiece_.jpg"),
  Rails.root.join("app/assets/images/hml_css_.jpg"),
  Rails.root.join("app/assets/images/0ruby.jpg"),
]

item_tags = [
  ["Ruby", "プログラミング", "入門"],
  ["Python", "プログラミング", "入門"],
  ["ジャンプ","漫画", "ワンピース"],
  ["ジャンプ", "漫画","妹系","抜き"],
  ["HTML","CSS", "プログラミング", "入門"],
  ["Ruby","情報", "プログラミング", "入門"],
]

# 各アイテムに画像とタグを追加
items.each_with_index do |item, index|
  # 画像をアタッチする（ActiveStorageの場合）
  image_path = item_images[index]

  if File.exist?(image_path)
    item.image.attach(io: File.open(image_path), filename: File.basename(image_path), content_type: 'image/jpeg')
  else
    Rails.logger.warn "画像ファイルが見つかりません: #{image_path}"
  end

  # タグを追加する（acts-as-taggable-onの場合）
  item_tags[index].each { |tag| item.tag_list.add(tag) }
  item.save
end
