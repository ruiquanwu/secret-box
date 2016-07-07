class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :options
      t.string :shippment
      t.string :carrier
      t.string :track_number
      t.integer :album_id
      t.float :total_price
      t.string :status

      t.timestamps null: false
    end
  end
end
