class ChangeNameInPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :prefecture, :prefecture_code
  end
end
