class AddColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :prefecture, :string
    add_column :posts, :address, :string
    add_column :posts, :area, :string
    add_column :posts, :type, :string
    add_column :posts, :objective, :string
    add_column :posts, :features, :text
    add_column :posts, :people, :string
    add_column :posts, :score, :integer
  end
end
