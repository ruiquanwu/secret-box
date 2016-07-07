class AddPhotosizeToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :photo_size, :string
  end
end
