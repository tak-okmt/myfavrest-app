class AddCommunityidToPosts < ActiveRecord::Migration[5.2]
  def up
    add_reference :posts, :community, null: false, index: true
  end

  def down
    remove_reference :posts, :community, index: true
  end

end
