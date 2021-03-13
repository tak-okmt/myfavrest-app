class CreateCommunities < ActiveRecord::Migration[5.2]
  def change
    create_table :communities do |t|
      t.string :name
      t.integer :create_user_id, null: false
      t.integer :publish_flg, null: false, default: 0

      t.timestamps
    end
  end
end
