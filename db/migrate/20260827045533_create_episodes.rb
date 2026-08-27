class CreateEpisodes < ActiveRecord::Migration[8.1]
  def change
    create_table :episodes do |t|
      t.string :title
      t.string :original_title
      t.integer :year
      t.references :season, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
