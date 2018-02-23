module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".fulltitle"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def link_to_add_term builder, lesson_word
    id = lesson_word.object_id
    lesson_word.build_word.definitions.build
    fields = builder.fields_for :lesson_words, lesson_word,
      child_index: id do |lw|
      render "lesson_word", f: lw, view_only: false
    end
    link_to t(".add_term"), "#", class: "add_fields btn btn-primary",
      data: {id: id, fields: fields.delete("\n")}
  end

  def finish_msg msg
    @msg = msg
  end

  def words_size size
    @size_of_words = size
  end

  def existing_word word
    @current_word = word
  end
end
