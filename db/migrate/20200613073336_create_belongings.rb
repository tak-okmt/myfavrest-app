class CreateBelongings < ActiveRecord::Migration[5.2]
  def change
    create_table :belongings do |t|
      t.integer :user_id
      t.integer :community_id
      t.integer :admin_flg, default: 0

      t.timestamps
    end
  end
end
