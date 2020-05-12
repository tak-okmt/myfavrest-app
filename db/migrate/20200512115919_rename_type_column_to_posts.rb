class RenameTypeColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :type, :restaurant_type
  end
end
