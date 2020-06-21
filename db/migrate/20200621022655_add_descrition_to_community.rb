class AddDescritionToCommunity < ActiveRecord::Migration[5.2]
  def change
    add_column :communities, :description, :text
  end
end
