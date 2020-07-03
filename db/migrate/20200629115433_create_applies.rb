class CreateApplies < ActiveRecord::Migration[5.2]
  def change
    create_table :applies do |t|
      t.bigint :user_id
      t.bigint :community_id

      t.timestamps
    end
  end
end
