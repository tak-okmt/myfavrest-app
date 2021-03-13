class AddIndexToCommunities < ActiveRecord::Migration[5.2]
  def up
    add_index :communities, [:name, :create_user_id], unique: true
    add_index :applies, [:user_id, :community_id], unique: true
    add_index :belongings, [:user_id, :community_id], unique: true
  end

  def down
    remove_index :communities, [:name, :create_user_id]
    remove_index :applies, [:user_id, :community_id]
    remove_index :belongings, [:user_id, :community_id]
  end
end
