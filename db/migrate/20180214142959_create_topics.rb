class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :name
      t.boolean :blocked
      t.string :picture
      t.references :creator, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
