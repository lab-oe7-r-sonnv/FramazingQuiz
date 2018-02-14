class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.references :teacher, foreign_key: {to_table: :users}
      t.string :name
      t.string :picture
      t.boolean :blocked

      t.timestamps
    end
  end
end
