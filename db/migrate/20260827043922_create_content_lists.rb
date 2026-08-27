class CreateContentLists < ActiveRecord::Migration[8.1]
  def change
    create_table :content_lists do |t|
      t.references :list, null: false, foreign_key: true
      t.references :content, polymorphic: true, null: false
      t.integer :position

      t.timestamps
    end
  end
end
