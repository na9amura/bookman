class CreateTagAssigns < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_assigns do |t|
      t.references :tag
      t.references :book

      t.timestamps
    end
  end
end
