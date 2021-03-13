class ChangeColumnDefaultToPosts < ActiveRecord::Migration[5.2]
  def up
    change_column_null :posts, :likes_count, false, 0
    change_column :posts, :likes_count, :integer, default: 0
  end

  def down
    change_column_null :posts, :likes_count, true, nil
    change_column :posts, :likes_count, :integer, default: nil
  end
end