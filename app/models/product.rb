class Product < ApplicationRecord
  
  has_one_attached :image 
  
   belongs_to :genre
   belongs_to :order_detail
   has_many :cart_items, dependent: :destroy


  
end
