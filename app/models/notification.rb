class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifier, inverse_of: nil, class_name: User.name
  belongs_to :lesson

  scope :desc, ->{order created_at: :desc}

  validates :user, presence: true
  validates :notifier, presence: true
  validates :lesson, presence: true

  def broadcast_bookmark
    ActionCable.server.broadcast "bookmark_channel_#{user.id}",
      event: event,
      bookmarker: notifier.name,
      created_at: created_at.strftime("%Y/%m/%d %H:%M:%S"),
      lesson: lesson.name
  end
end
