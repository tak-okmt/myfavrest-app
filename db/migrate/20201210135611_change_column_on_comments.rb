class ChangeColumnOnComments < ActiveRecord::Migration[5.2]
  def up
    change_column_null :comments, :user_id, false
    change_column_null :comments, :post_id, false
    change_column :comments, :content, :text, limit: 300
    change_column_null :belongings, :user_id, false
    change_column_null :belongings, :community_id, false
    change_column_null :belongings, :admin_flg, false
    change_column_null :applies, :user_id, false
    change_column_null :applies, :community_id, false
  end
  def down
    change_column_null :comments, :user_id, true
    change_column_null :comments, :post_id, true
    change_column :comments, :content, :text
    change_column_null :belongings, :user_id, true
    change_column_null :belongings, :community_id, true
    change_column_null :belongings, :admin_flg, true
    change_column_null :applies, :user_id, true
    change_column_null :applies, :community_id, true
  end
end
