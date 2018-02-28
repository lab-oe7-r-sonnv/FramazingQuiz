class FlashcardsSupports
  attr_reader :words

  def initialize words
    @words = words
  end

  def heading
    @heading = I18n.t "flashcards.new.panel_heading"
  end

  def words_info
    @words_info = {
      size: words.count,
      new: flashcards_settings.new_learnt_words
    }
  end

  def progress
    @progress = {
      class: flashcards_settings.progress_class,
      name: I18n.t("flashcards.new.progress"),
      bar: (words_info[:new].to_f / words_info[:size] * 100),
      id: flashcards_settings.progress_id
    }
  end

  private

  def flashcards_settings
    Settings.flashcards
  end
end
