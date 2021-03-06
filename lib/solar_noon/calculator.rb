require 'date'

module SolarNoon

  class Calculator

    attr_reader :date

    def initialize(date)
      @date = date.to_datetime
    end

    # Calculate noon for a given date at a given longitude
    # Takes a Date, DateTime or Time and returns a Time instance at solar noon
    # for that day. Time returned is UTC; to get local time call `getlocal on the
    # result.
    def calculate(longitude)
      raise ArgumentError.new "Invalid longitude" unless -180.0 <= longitude && longitude <= 180.0

      eq_time = true_solar_time_diff_mean_solar_time

      minutes = 720 - (longitude * 4) - eq_time # in minutes

      # Returned time is UTC
      noon = Time.utc(date.year, date.month, date.day) + (minutes * 60)

      noon.to_datetime
    end

    private

    # convert Julian Day to centuries since J2000.0.
    # return the T value corresponding to the Julian Day
    def jd_centuries
      (date.jd - 2451545.0) / 36525.0
    end

    # calculate the difference between true solar time and mean solar time
    # Takes a Date or DateTime and returns the equation of time in minutes of time
    def true_solar_time_diff_mean_solar_time
      epsilon = obliquity_correction
      l0      = geometric_mean_longitude_of_sun
      e       = earth_orbit_eccentricity
      m       = geometric_mean_anomaly_sun
      y       = Math.tan(degree_to_radians(epsilon) / 2.0) ** 2

      sin2l0  = Math.sin(2.0 * degree_to_radians(l0))
      sinm    = Math.sin(degree_to_radians(m))
      cos2l0  = Math.cos(2.0 * degree_to_radians(l0))
      sin4l0  = Math.sin(4.0 * degree_to_radians(l0))
      sin2m   = Math.sin(2.0 * degree_to_radians(m))

      etime   = y * sin2l0 - 2.0 * e * sinm + 4.0 * e * y * sinm * cos2l0 - 0.5 * y * y * sin4l0 - 1.25 * e * e * sin2m

      radian_to_degrees(etime) * 4.0
    end

    # calculate the corrected obliquity of the ecliptic
    # Takes a Date or DateTime and returns the corrected obliquity in degrees
    def obliquity_correction
      t = jd_centuries
      e0 = mean_obliquity_of_ecliptic
      omega = 125.04 - 1934.136 * t
      e0 + 0.00256 * Math.cos(degree_to_radians(omega))
    end

    # calculate the Geometric Mean Longitude of the Sun
    # Takes a Date or DateTime and returns the Geometric Mean Longitude of the
    # Sun in degrees.
    def geometric_mean_longitude_of_sun
      t = jd_centuries

      l0 = 280.46646 + t * (36000.76983 + 0.0003032 * t)

      l0 -= 360.0 while l0 > 360.0
      l0 += 360.0 while l0 < 0.0

      l0
    end

    # calculate the eccentricity of earth's orbit
    # Takes a Date or DateTime and returns the unitless eccentricity
    def earth_orbit_eccentricity
      t = jd_centuries
      0.016708634 - t * (0.000042037 + 0.0000001267 * t)
    end

    # calculate the Geometric Mean Anomaly of the Sun
    # Takes a Date or DateTime and returns the Geometric Mean Anomaly of the Sun
    # in degrees
    def geometric_mean_anomaly_sun
      t = jd_centuries
      357.52911 + t * (35999.05029 - 0.0001537 * t)
    end

    # calculate the mean obliquity of the ecliptic
    # Takes a Date or DateTime and returns the mean obliquity in degrees
    def mean_obliquity_of_ecliptic
      t = jd_centuries
      seconds = 21.448 - t * (46.8150 + t * (0.00059 - t * (0.001813)))
      23.0 + (26.0 + (seconds / 60.0)) / 60.0
    end

    # Convert degree angle to radians
    def degree_to_radians(angle)
      Math::PI * angle / 180.0
    end

    # Convert radian angle to degrees
    def radian_to_degrees(angle)
      180.0 * angle / Math::PI
    end

  end

end
