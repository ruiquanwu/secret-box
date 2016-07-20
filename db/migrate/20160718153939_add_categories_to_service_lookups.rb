class AddCategoriesToServiceLookups < ActiveRecord::Migration
  def change
    add_column :service_lookups, :categories, :string
    add_index :service_lookups, :categories
  end
end
