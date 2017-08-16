class CreateCheckouts < ActiveRecord::Migration[5.1]
  def change
    create_table :checks do |t|
      t.references :user, index: true
      t.references :book, index: true

      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
