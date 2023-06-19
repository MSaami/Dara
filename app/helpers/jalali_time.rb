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
end
