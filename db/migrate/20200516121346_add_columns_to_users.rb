class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :birth_ym, :string
    add_column :users, :work_idt, :string
    add_column :users, :work_comp, :string
    add_column :users, :work_ocpn, :string
    add_column :users, :gender, :string
    add_column :users, :image, :string
  end
end
