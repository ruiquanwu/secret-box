class AddPhotoNumberToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :photo_number, :integer
    add_index :photos, :photo_number
  end
end
