class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details

  enum payment_method: { credit_card: 0, transfer: 1}
  enum status: {
    awaiting_payment: 0,
    confirmed_payment: 1,
    in_production: 2,
    preparing_to_ship: 3,
    done: 4
  }

  def address_display
    "〒#{self.post_code.to_s.insert(3, "-")} #{self.address} #{self.name}"
  end

  def address_display2
    "〒#{self.post_code.to_s.insert(3, "-")} #{self.address}"
  end


end
