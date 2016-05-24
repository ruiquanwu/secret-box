class AddPhotoPerPageToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :photo_per_page, :integer
    add_index :albums, :photo_per_page
  end
end
