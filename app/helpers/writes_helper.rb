module WritesHelper
  def lesson_session
    session[:lesson]
  end

  def load_session
    @words_size = lesson_session["words_size"].to_i
    @current_word = Word.find_by id: lesson_session["current_word_id"].to_i
    @remain_words = lesson_session["remain_words_ids"].to_a
    @correct_words = lesson_session["correct_words_ids"].to_a
    @incorrect_words = lesson_session["incorrect_words_ids"].to_a
  end
end
