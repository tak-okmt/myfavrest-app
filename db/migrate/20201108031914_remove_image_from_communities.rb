class RemoveImageFromCommunities < ActiveRecord::Migration[5.2]
  def up
    remove_column :posts, :image
    remove_column :users, :image
  end

  def down
    add_column :posts, :image
    add_column :users, :image
  end
end
