class AddFeaturesToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :features, :string
  end
end
