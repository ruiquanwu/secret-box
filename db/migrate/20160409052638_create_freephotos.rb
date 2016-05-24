class CreateFreephotos < ActiveRecord::Migration
  def change
    create_table :freephotos do |t|

      t.timestamps null: false
    end
  end
end
