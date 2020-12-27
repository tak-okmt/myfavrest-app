class ChangeColumnOnCommunities < ActiveRecord::Migration[5.2]
  def up
    change_column_null :communities, :name, false
    change_column :communities, :name, :string, limit: 20
    change_column :communities, :description, :string, limit: 50
  end
  def down
    change_column_null :communities, :name, true
    change_column :communities, :name, :string
    change_column :communities, :description, :string
  end
end
