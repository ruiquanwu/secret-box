class CreateSamplePictures < ActiveRecord::Migration
  def change
    create_table :sample_pictures do |t|
      t.string :size
      t.float :price

      t.timestamps null: false
    end
  end
end
