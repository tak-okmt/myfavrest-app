class ReCreateCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :codes do |t|
      t.string :code_id, null: false
      t.string :sub_id, null: false
      t.string :code, null: false
      t.string :name

      t.timestamps
      t.index [:code_id, :sub_id, :code], unique: true
    end    
  end
end
