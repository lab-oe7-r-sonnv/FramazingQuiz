class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifier, inverse_of: nil, class_name: User.name
  belongs_to :lesson

  scope :desc, ->{order created_at: :desc}
  scope :events, ->{select("event").distinct}

  validates :user, presence: true
  validates :notifier, presence: true
  validates :lesson, presence: true

  def broadcast name
    ActionCable.server.broadcast "#{name}_channel_#{user.id}",
      event: event.tr("_", " "),
      broadcaster: notifier.name,
      streamer: user.name,
      third_person: lesson.user.name,
      created_at: created_at.strftime("%Y/%m/%d %H:%M:%S"),
      lesson: lesson.name
  end
end
