class AddIndexToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
