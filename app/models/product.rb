class Product < ApplicationRecord

  has_one_attached :image

  belongs_to :genre
  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy


  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end

       image.variant(resize_to_limit: [width, height]).processed
  end


#税込金額を表示させるための記述
  def add_tax_sales_price
    (self.price_without_tax * 1.10).round
  end

end
