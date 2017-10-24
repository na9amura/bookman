class CreateShelves < ActiveRecord::Migration[5.1]
  def change
    create_table :shelves do |t|
      t.string :name, null: false
      t.references :admin_user

      t.timestamps
    end
    change_table :books do |t|
      t.references :shelf
    end
  end
end
