class ChangeColumnTypeToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :likes_count, :integer
  end
end
