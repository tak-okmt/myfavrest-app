class ChangePostsTitleLimit30 < ActiveRecord::Migration[5.2]
  def up
    change_column :posts, :title, :string, limit: 30    
  end
  def down
    change_column :posts, :title, :string
  end
end
