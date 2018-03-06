class RemoveTopicIdFromLessons < ActiveRecord::Migration[5.1]
  def change
    remove_column :lessons, :topic_id
  end
end
