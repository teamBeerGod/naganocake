class ShippingAddress < ApplicationRecord

  belongs_to :customer

  def address_display
    "〒#{post_code} #{address} #{delivery_name}"
  end

end
