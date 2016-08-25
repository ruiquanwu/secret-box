class AddRotateAttributesToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :rotate_landscape, :boolean
    add_column :pictures, :rotate_portrait, :boolean
  end
end
