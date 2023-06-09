class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  def full_name
    self.last_name + " " + self.first_name
  end

  def address_display
    "〒#{post_code.to_s.insert(3, "-")} #{address}" + "  "+ self.full_name
  end

end
