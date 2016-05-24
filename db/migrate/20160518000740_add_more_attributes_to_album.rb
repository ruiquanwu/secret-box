class AddMoreAttributesToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :has_memo, :boolean
    add_column :albums, :number_in_stock, :integer
    add_column :albums, :price, :float
  end
end
