class CreateServiceLookups < ActiveRecord::Migration
  def change
    create_table :service_lookups do |t|
      t.string :name
      t.string :description
      t.float :price

      t.timestamps null: false
    end
  end
end
