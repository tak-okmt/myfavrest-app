class AddUseridToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_id, :string
  end
end
