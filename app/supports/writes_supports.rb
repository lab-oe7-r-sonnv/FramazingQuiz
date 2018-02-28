class WritesSupports
  attr_reader :lesson

  def initialize new_lesson, remain_ids, incorrect_ids, correct_ids
    new_lesson.setup_write remain_ids, incorrect_ids, correct_ids
    @lesson = new_lesson
  end

  def write_info
    Hash[
      remain_words_ids: lesson.remain_words_ids,
      incorrect_words_ids: lesson.incorrect_words_ids,
      correct_words_ids: lesson.correct_words_ids,
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
      css_class: remain_settings.css_class,
      name: I18n.t("writes.remain.name"),
      bar: (write_info[:remain_words_ids].count /
        write_info[:words_size].to_f * 100),
      id: remain_settings.id
    ]
  end

  def correct
    Hash[
      css_class: correct_settings.css_class,
      name: I18n.t("writes.correct.name"),
      bar: (write_info[:correct_words_ids].count /
        write_info[:words_size].to_f * 100),
      id: correct_settings.id
    ]
  end

  def incorrect
    Hash[
      css_class: incorrect_settings.css_class,
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
end
