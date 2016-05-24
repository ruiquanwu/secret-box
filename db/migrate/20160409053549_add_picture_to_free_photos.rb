class AddPictureToFreePhotos < ActiveRecord::Migration
  def change
    add_column :freephotos, :picture, :string
  end
end
