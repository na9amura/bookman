class CreatePublishers < ActiveRecord::Migration[5.1]
  def change
    create_table :publishers do |t|
      t.string :name

      t.timestamps
    end

    change_table :books do |t|
      t.references :publisher
    end
  end
end
