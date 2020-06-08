class AddColumnsToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :title, :string
    add_column :comments, :score, :integer
    add_column :comments, :scene, :string
    add_column :comments, :people, :string
  end
end
