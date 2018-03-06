class DropTopics < ActiveRecord::Migration[5.1]
  def change
    drop_table :topics, force: :cascade
  end
end
