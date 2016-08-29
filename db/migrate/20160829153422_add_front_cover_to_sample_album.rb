class AddFrontCoverToSampleAlbum < ActiveRecord::Migration
  def change
    add_column :sample_albums, :has_front_cover, :boolean
    add_column :sample_albums, :front_cover_width_percentage, :float
    add_column :sample_albums, :front_cover_height_percentage, :float
  end
end
