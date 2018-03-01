class WritesSupports
  attr_reader :lesson

  def initialize new_lesson, remain_ids, incorrect_ids, correct_ids, is_correct
    new_lesson.setup_write remain_ids, incorrect_ids, correct_ids, is_correct
    @lesson = new_lesson
  end

  def write_info
    Hash[
      is_correct: lesson_info[:is_correct],
      remain_words_ids: lesson_info[:remains],
      incorrect_words_ids: lesson_info[:incorrects],
      correct_words_ids: lesson_info[:corrects],
      current_word_id: lesson.current_word.id,
      words_size: lesson.words.count
    ]
  end

  def heading
    @heading = I18n.t "writes.heading"
  end

  def size
    @size = Settings.writes.size
  end

  def remain
    Hash[
      bar_class: remain_settings.bar_class,
      pbar_class: remain_settings.pbar_class,
      name: I18n.t("writes.remain.name"),
      bar: (write_info[:remain_words_ids].count /
        write_info[:words_size].to_f * 100),
      id: remain_settings.id
    ]
  end

  def correct
    Hash[
      bar_class: correct_settings.bar_class,
      pbar_class: correct_settings.pbar_class,
      name: I18n.t("writes.correct.name"),
      bar: (write_info[:correct_words_ids].count /
        write_info[:words_size].to_f * 100),
      id: correct_settings.id
    ]
  end

  def incorrect
    Hash[
      bar_class: incorrect_settings.bar_class,
      pbar_class: incorrect_settings.pbar_class,
      name: I18n.t("writes.incorrect.name"),
      bar: (write_info[:incorrect_words_ids].count /
        write_info[:words_size].to_f * 100),
      id: incorrect_settings.id
    ]
  end

  private

  def remain_settings
    Settings.writes.remain
  end

  def incorrect_settings
    Settings.writes.incorrect
  end

  def correct_settings
    Settings.writes.correct
  end

  def lesson_info
    lesson.lesson_info
  end
end
