class AddPhotosizeToSampleAlbums < ActiveRecord::Migration
  def change
    add_column :sample_albums, :photo_size, :string
  end
end
