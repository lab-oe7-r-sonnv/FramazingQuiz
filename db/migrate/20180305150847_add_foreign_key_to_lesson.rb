class AddForeignKeyToLesson < ActiveRecord::Migration[5.1]
  def change
    add_reference :lessons, :user, index: true, foreign_key: true
  end
end
