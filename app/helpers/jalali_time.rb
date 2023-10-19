module JalaliTime
  def current_year
    JalaliDate.new(Date.today).year
  end

  def current_month
    JalaliDate.new(Date.today).month
  end

  def current_day
    JalaliDate.new(Date.today).day
  end

  def first_day_of_month
    JalaliDate.today - current_day + 1
  end

  def last_day_of_month
    month_days = 31 
    if [7,8,9,10,11].include? current_month
      month_days = 30
    end
    if !JalaliDate.today.leap? && current_month == 12
      month_days = 29
    end
    days_til_end = month_days - current_day
    JalaliDate.today.+(days_til_end)
  end
end
