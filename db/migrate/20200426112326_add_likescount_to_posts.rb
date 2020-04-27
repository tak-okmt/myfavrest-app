class AddLikescountToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :likes_count, :string
  end
end
