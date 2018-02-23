class FlashcardsController < ApplicationController
  attr_reader :learnt_words, :not_learnt_words

  before_action :load_data, :learning, only: %i(update)

  def new
    setup_flashcard
    ajax_learn
  end

  def update
    finish_msg t(".finish_msg") if finish_learning?
    existing_word Word.find_by id: learnt_words.last
    ajax_learn
  end

  private

  def ajax_learn
    respond_to do |format|
      format.html{render :new}
      format.js
    end
  end

  def learning
    return learn_next if next?
    return learn_prev if prev?
  end

  def learn_next
    random_word = not_learnt_words.sample
    add_word learnt_words, random_word
    remove_word not_learnt_words, random_word
  end

  def learn_prev
    last_word = learnt_words.last
    add_word not_learnt_words, last_word
    remove_word learnt_words, last_word
  end

  def setup_flashcard
    setup_data
    finish_msg ""
    remove_word not_learnt_words, learnt_words
  end

  def setup_data
    @not_learnt_words = Lesson.find_by(id: params[:id]).words.ids
    words_size not_learnt_words.count
    @learnt_words = [] << not_learnt_words.sample
    existing_word Word.find_by id: learnt_words
  end

  def load_data
    @not_learnt_words = params[:not_learnt_words].split(" ").map(&:to_i)
    @learnt_words = params[:learnt_words].split(" ").map(&:to_i)
    words_size params[:size_of_words]
  end

  def next?
    params[:learn] == "next" && learnt_words.count < params[:size_of_words].to_i
  end

  def prev?
    params[:learn] == "prev" && learnt_words.count > 1
  end

  def finish_learning?
    learnt_words.count == params[:size_of_words].to_i
  end
end
