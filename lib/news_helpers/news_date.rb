module NewsDate
  def NewsDate.date_today
    # Pulls today's date and returns it as a string in the format YYYYMMDD.

    time = Time.new.utc + Time.zone_offset("EST")
    year = time.year.to_s
    month = time.month.to_s
    day = time.day.to_s

    # Ensure month is 2 digits long
    if month.length == 1
      month = "0" + month
    end

    # Ensure day is 2 digits long
    if day.length == 1
      day = "0" + day
    end

    return year + month + day
  end
end