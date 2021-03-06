module ApplicationHelper
  include WritesHelper

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
    link_to t(".add_term"), "#", class: "add_fields btn btn-default",
      data: {id: id, fields: fields.delete("\n")}
  end

  def recent_topics topics, amount
    recent_topics = topics.recent.take amount
    render partial: "topics/simple_topic", collection: recent_topics, as: :topic
  end
end
