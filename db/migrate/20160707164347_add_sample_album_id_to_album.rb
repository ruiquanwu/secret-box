class AddSampleAlbumIdToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :sample_album_id, :integer
    add_index :albums, :sample_album_id
  end
end
