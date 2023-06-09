class CreateShippingAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_addresses do |t|
      t.integer :customer_id,                null: false, default: ""
      t.string :delivery_name,               null: false, default: ""
      t.string :post_code,                   null: false, default: ""
      t.string :address,                     null: false, default: ""
      t.timestamps
    end
  end
end
