class AddIdsToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :album_id, :integer
    add_index :pictures, :album_id
    add_column :pictures, :photo_id, :integer
    add_index :pictures, :photo_id
  end
end
