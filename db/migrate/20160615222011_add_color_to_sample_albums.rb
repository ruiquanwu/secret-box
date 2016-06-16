class AddColorToSampleAlbums < ActiveRecord::Migration
  def change
    add_column :sample_albums, :color, :string
  end
end
