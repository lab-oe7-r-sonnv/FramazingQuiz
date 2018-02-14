class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :picture
      t.references :topic, foreign_key: true
      t.boolean :blocked

      t.timestamps
    end
  end
end
