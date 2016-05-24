class AddAlbumlayoutToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :album_layout, :string
  end
end
