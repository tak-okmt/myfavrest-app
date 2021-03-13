class ChangeColumnTypeToUsersDate < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :birth_ym, :date
  end
end
