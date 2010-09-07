module CalendarsHelper
  def years
    current_year = Date.today.year.to_i
    (current_year..(current_year + 5)).inject([]) do |list, y|
      list << y
    end
  end

  def months
    [
      [ 'January', 1 ], 
      [ 'February', 2 ],
      [ 'March', 3 ],
      [ 'April', 4 ], 
      [ 'May', 5],
      [ 'June', 6], 
      [ 'July', 7],
      [ 'August', 8],
      [ 'September', 9],
      [ 'October', 10],
      [ 'November', 11],
      [ 'December', 12 ]
    ]
  end
end
