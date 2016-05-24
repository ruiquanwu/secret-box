class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :front_cover
      t.string :style
      t.string :avatar
      t.integer :max_page

      t.timestamps null: false
    end
  end
end
