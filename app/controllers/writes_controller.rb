class WritesController < ApplicationController
  attr_reader :lesson, :support, :words_size, :current_word, :remain_words,
    :incorrect_words, :correct_words, :is_correct

  before_action :find_lesson, only: %i(new update)
  before_action :load_session, :check_answer, only: :update

  def new
    @support = WritesSupports.new lesson, lesson.words.ids,
      Array.new, Array.new, is_correct
    save_write_info
  end

  def update
    return continue_writing unless finish_writing?
    reload_support
    render :show
  end

  private

  def check_answer
    if answer_is_correct?
      add_word correct_words, current_word_id
      @is_correct = "true"
    else
      add_word incorrect_words, current_word_id
      @is_correct = "false"
    end
    remove_word remain_words, current_word_id
  end

  def current_word_id
    current_word.id
  end

  def answer_is_correct?
    current_word.correct_definition.text == params[:word][:definition]
  end

  def finish_writing?
    correct_words.size == words_size
  end

  def continue_writing
    check_remain_words
    reload_support
    save_write_info
    ajax_continue
  end

  def save_write_info
    session[:lesson] = support.write_info
  end

  def check_remain_words
    lesson.setup_write remain_words, incorrect_words, correct_words, is_correct
    return lesson.new_word unless remain_words.empty?
    lesson.setup_write incorrect_words, Array.new, correct_words, is_correct
  end

  def reload_support
    @support = WritesSupports.new lesson, lesson_info[:remains],
      lesson_info[:incorrects], lesson_info[:corrects], is_correct
  end

  def ajax_continue
    respond_to do |format|
      format.html{render :new}
      format.js
    end
  end

  def lesson_info
    lesson.lesson_info
  end
end
