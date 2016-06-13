class CreateSampleAlbums < ActiveRecord::Migration
  def change
    create_table :sample_albums do |t|
      t.string :name
      t.string :avatar
      t.integer :max_page
      t.string :orientation
      t.integer :photo_per_page
      t.string :album_layout
      t.string :description
      t.boolean :has_memo
      t.integer :number_in_stock
      t.float :price

      t.timestamps null: false
    end
  end
end
