p '==================== customer create ===================='

3.times do |n|

 Customer.create!(

  last_name: "山田",

  first_name: "太郎#{n+1}号",

  last_name_kana: "ヤマダ",

  first_name_kana:"タロウ#{n+1}ゴウ",

  post_code: "100-8111",

  address: "東京都千代田区千代田１−１",

  phone_number: "111-1111-1111",

  email: "yamada.taro#{n+1}@nagano.com",

  password: "123456",

  is_deleted: false

 )

end



p '==================== admin create ===================='

3.times do |n|

 Admin.create!(

  email: "admin#{n+1}@nagano.com",

  password: "123456"

 )

end



p '==================== genre create ===================='

Genre.create!(name: "cake")

Genre.create!(name: "cookie")



p '==================== products create ===================='

Product.create!(

 genre_id: 1,

 name: "チョコケーキ",

 introduction: "チョコ味",

 price_without_tax: "100",

 is_active: true

)

Product.create!(

 genre_id: 2,

 name: "チョコクッキー",

 introduction: "チョコ味",

 price_without_tax: "100",

 is_active: true

)