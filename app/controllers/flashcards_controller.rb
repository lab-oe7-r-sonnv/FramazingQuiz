class FlashcardsController < ApplicationController
  attr_reader :lesson

  before_action :find_lesson, only: :new

  def new
    @support = FlashcardsSupports.new lesson.words
  end
end
