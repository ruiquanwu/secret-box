class AddContextToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :context, :string
  end
end
