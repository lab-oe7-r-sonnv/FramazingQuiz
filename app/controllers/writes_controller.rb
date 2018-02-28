class WritesController < ApplicationController
  attr_reader :lesson, :support, :words_size, :current_word, :remain_words,
    :incorrect_words, :correct_words

  before_action :find_lesson, only: %i(new update)
  before_action :load_session, :check_answer, only: :update

  def new
    @support = WritesSupports.new lesson,
      lesson.words.ids, Array.new, Array.new
    save_write_info
  end

  def update
    return continue_writing unless finish_writing?
    reload_support
    render :show
  end

  private

  def finish_writing?
    correct_words.size == words_size
  end

  def check_answer
    if answer_is_correct?
      add_word correct_words, current_word_id
    else
      add_word incorrect_words, current_word_id
    end
    remove_word remain_words, current_word_id
  end

  def current_word_id
    current_word.id
  end

  def answer_is_correct?
    current_word.correct_definition.text == params[:word][:definition]
  end

  def continue_writing
    check_remain_words
    reload_support
    save_write_info
    render :new, support: support
  end

  def save_write_info
    session[:lesson] = support.write_info
  end

  def check_remain_words
    lesson.setup_write remain_words, incorrect_words, correct_words
    return lesson.new_word unless remain_words.empty?
    lesson.setup_write incorrect_words, Array.new, correct_words
  end

  def reload_support
    @support = WritesSupports.new lesson, lesson.remain_words_ids,
      lesson.incorrect_words_ids, lesson.correct_words_ids
  end
end
