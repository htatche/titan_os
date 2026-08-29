class AddContentListIndexes < ActiveRecord::Migration[8.1]
  def change
    add_index :content_lists, [ :list_id, :position ]
    add_index :content_lists, [ :list_id, :content_type, :position ]
    add_index :content_lists, [ :content_type, :content_id ]
  end
end
