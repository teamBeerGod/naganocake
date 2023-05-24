class ShippingAddress < ApplicationRecord

  belongs_to :customer

  def address_display
    "〒#{post_code.to_s.insert(3, "-")} #{address} #{delivery_name}"
  end

end
