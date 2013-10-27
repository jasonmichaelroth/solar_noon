require 'minitest_helper'
require 'solar_noon'

class SolarNoonTest < Minitest::Spec

  def assert_within_one_minute(expected, actual)
    flunk "#{actual.inspect} is not a Time or DateTime instance" unless [DateTime, Time].include? actual.class
    flunk "#{expected.inspect} is not a Time or DateTime instance" unless [DateTime, Time].include? expected.class
    flunk "#{actual.inspect} is not the same class as #{expected.inspect}" unless expected.is_a? actual.class
    assert_in_delta expected, actual, 60
  end

  test "#calculate" do
    skip "PENDING"
    "should work with a Date and longitude"
    "should work with a DateTime and longitude"
    "should work with a Time and longitude"
  end

  test "DST time - 2011-03-26 11:42:36 MDT at -105.0" do
    noon = Date.civil(2011, 3, 26).solar_noon(-105.0)
    assert_within_one_minute DateTime.civil(2011, 3, 26, 19, 5, 00, 'UTC'), noon

    noon = DateTime.civil(2011, 3, 26, 11, 42, 36).solar_noon(-105.0)
    assert_within_one_minute DateTime.civil(2011, 3, 26, 19, 5, 00, 'UTC'), noon

    noon = Time.local(2011, 3, 26, 11, 42, 36).solar_noon(-105.0)
    assert_within_one_minute DateTime.civil(2011, 3, 26, 19, 5, 00, 'UTC'), noon
  end

  test "UTC time - 2001-06-12 19:18:15 UTC at 82.5" do
    noon = Date.civil(2001, 6, 12).solar_noon(82.5)
    assert_within_one_minute DateTime.civil(2001, 6, 12, 6, 29, 00, 'UTC'), noon

    noon = DateTime.civil(2001, 6, 12, 19, 18, 15, "UTC").solar_noon(82.5)
    assert_within_one_minute DateTime.civil(2001, 6, 12, 6, 29, 00, 'UTC'), noon

    noon = Time.utc(2001, 6, 12, 19, 18, 15).solar_noon(82.5)
    assert_within_one_minute DateTime.civil(2001, 6, 12, 6, 29, 00, 'UTC'), noon
  end

  test "future time - 2031-11-28 05:07:26 MDT at 132.2" do
    noon = Date.civil(2031, 11, 28).solar_noon(132.2)
    assert_within_one_minute DateTime.civil(2031, 11, 28, 2, 59, 00, 'UTC'), noon

    noon = DateTime.civil(2031, 11, 28, 5, 7, 26, "MDT").solar_noon(132.2)
    assert_within_one_minute DateTime.civil(2031, 11, 28, 2, 59, 00, 'UTC'), noon

    noon = Time.utc(2031, 11, 28, 5, 7, 26).solar_noon(132.2)
    assert_within_one_minute DateTime.civil(2031, 11, 28, 2, 59, 00, 'UTC'), noon
  end

end
