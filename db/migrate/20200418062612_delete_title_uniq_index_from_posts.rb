class DeleteTitleUniqIndexFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_index :posts, :title
  end
end
