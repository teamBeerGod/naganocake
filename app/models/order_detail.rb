class OrderDetail < ApplicationRecord

  belongs_to :product
  belongs_to :order

  enum making_status: {
    cannot_start: 0,
    pending_production: 1,
    in_production: 2,
    done: 3
  }

  def calc_subtotal
    (self.price_including_tax * self.quantity).round
  end

end
