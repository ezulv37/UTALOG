class CreatePractices < ActiveRecord::Migration[6.1]
  def change
    create_table :practices do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :artist
      t.integer :key
      t.text :comment
      t.integer :score
      t.string :result_image1
      t.string :result_image2

      t.timestamps
    end
  end
end
