class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.references :book
      t.string :name
      t.string :color_code

      t.timestamps
    end
  end
end
