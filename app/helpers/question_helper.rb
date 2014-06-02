module QuestionHelper

  def all_tag_list object
    if object.tags
      raw object.sorted_by_abc_tags.map {|t| link_to t, tag_questions_path(t.name), class: "btn btn-xs tag"}.join(" ")
    end
  end
end
