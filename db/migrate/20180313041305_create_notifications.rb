class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :event
      t.references :lesson, foreign_key: true
      t.references :user, foreign_key: true
      t.references :bookmarker, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
