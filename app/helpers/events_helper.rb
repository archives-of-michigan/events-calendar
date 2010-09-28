module EventsHelper
  def event_date(date)
    return '' if date.nil?

    if date.hour == 0 && date.min == 0
      date.strftime '%A, %B %d, %Y'
    else
      date.strftime '%A, %B %d, %Y %I:%M%p'
    end
  end

  def event_category_link_list(categories)
    categories.map do |category|
      link_to h(category.name), category_path(category)
    end.to_sentence.html_safe
  end
end
