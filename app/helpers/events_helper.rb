module EventsHelper
  def event_date(date)
    return '' if date.nil?

    if date.hour == 0 && date.min == 0
      date.strftime '%A, %B %d, %Y'
    else
      date.strftime '%A, %B %d, %Y %I:%M%p'
    end
  end
end
