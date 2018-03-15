class AddBookmarkerToLesson < ActiveRecord::Migration[5.1]
  def change
    add_reference :lessons, :bookmarker, index: true, foreign_key: {to_table: :users}
  end
end
