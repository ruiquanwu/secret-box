class AddFeaturesToSampleAlbums < ActiveRecord::Migration
  def change
    add_column :sample_albums, :features, :string
  end
end
