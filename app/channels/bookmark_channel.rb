class BookmarkChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bookmark_channel_#{current_user.id}"
  end
end
