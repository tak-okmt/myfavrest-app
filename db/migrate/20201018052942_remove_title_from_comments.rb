class RemoveTitleFromComments < ActiveRecord::Migration[5.2]
  def up
    remove_column :comments, :title
    remove_column :posts, :objective
    remove_column :posts, :features
    remove_column :posts, :people
    remove_column :posts, :score
    remove_column :posts, :latitude
    remove_column :posts, :longitude
    remove_column :users, :age
    remove_column :users, :work_comp
  end

  def down
    add_column :comments, :title, :string
    add_column :posts, :objective, :string
    add_column :posts, :features, :text
    add_column :posts, :people, :string
    add_column :posts, :score, :integer
    add_column :posts, :latitude, :float
    add_column :posts, :longitude, :float
    add_column :users, :age, :string
    add_column :users, :work_comp, :string
  end
end
