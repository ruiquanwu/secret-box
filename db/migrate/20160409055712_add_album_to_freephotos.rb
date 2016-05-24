class AddAlbumToFreephotos < ActiveRecord::Migration
  def change
    add_column :freephotos, :album_id, :integer
    add_index :freephotos, :album_id
  end
end
