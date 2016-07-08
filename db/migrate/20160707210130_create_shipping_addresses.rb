class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.string :name
      t.string :address_line1
      t.string :state
      t.string :city
      t.string :zipcode
      t.integer :order_id

      t.timestamps null: false
    end
  end
end
