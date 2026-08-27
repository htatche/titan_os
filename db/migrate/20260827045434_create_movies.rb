class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :original_title
      t.integer :year

      t.timestamps
    end
  end
end
