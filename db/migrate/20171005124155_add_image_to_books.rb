class AddImageToBooks < ActiveRecord::Migration[5.1]
  def change
    change_table :books do |t|
      t.text :image_data
    end
  end
end
