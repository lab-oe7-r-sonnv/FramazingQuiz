class FinishWritingChannel < ApplicationCable::Channel
  def subscribed
    stream_from "finish_writing_channel_#{current_user.id}"
  end
end
