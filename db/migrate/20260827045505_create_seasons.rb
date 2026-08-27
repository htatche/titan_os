class CreateSeasons < ActiveRecord::Migration[8.1]
  def change
    create_table :seasons do |t|
      t.string :title
      t.string :original_title
      t.integer :year
      t.references :tv_show, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
