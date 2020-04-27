class AddUserIdIndexToUsers < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM users;'
    add_index :users, :user_id, unique: true
    change_column_null :users, :user_id, false
  end

  def down
    remove_index :users, :user_id
    change_column_null :users, :user_id, true
  end
end
