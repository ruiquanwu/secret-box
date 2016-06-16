class AddColorToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :color, :string
  end
end
