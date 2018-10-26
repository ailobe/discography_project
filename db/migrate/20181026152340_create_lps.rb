class CreateLps < ActiveRecord::Migration[5.2]
  def change
    create_table :lps do |t|
      t.string :name
      t.text :description
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
