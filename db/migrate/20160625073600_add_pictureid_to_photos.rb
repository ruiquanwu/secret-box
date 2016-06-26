class AddPictureidToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :picture_id, :integer
  end
end
