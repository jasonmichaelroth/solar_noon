require File.expand_path('../solar_noon/calculator', __FILE__)

module SolarNoon
  module Extensions
    def solar_noon(longitude)
      SolarNoon::Calculator.new(self).calculate(longitude)
    end
  end
end

class Date
  include SolarNoon::Extensions
end

class DateTime
  include SolarNoon::Extensions
end

class Time
  include SolarNoon::Extensions
end
