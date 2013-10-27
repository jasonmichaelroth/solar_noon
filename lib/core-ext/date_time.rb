class DateTime

  # return a DateTime instance of solar noon for the specified day and longitude
  def solar_noon(longitude)
    SolarNoon::Calculator.new(self).calculate(longitude)
  end

end
