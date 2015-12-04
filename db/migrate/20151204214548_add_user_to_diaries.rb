class AddUserToDiaries < ActiveRecord::Migration
  def change
    add_column :diaries, :user_id, :integer
    add_index :diaries, :user_id
  end
end
