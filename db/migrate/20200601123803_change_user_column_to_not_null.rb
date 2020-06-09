class ChangeUserColumnToNotNull < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :user_id
  end

  def down
    add_column :users, :user_id, :string
  end
end
