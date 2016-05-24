class AddOrientationToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :orientation, :string
    add_index :albums, :orientation
  end
end
