class RenameRestaurantTypeColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :restaurant_type, :rest_type
  end
end
