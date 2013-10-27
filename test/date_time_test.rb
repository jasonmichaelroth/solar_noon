require 'minitest_helper'
require 'timing_helper'
require 'solar_noon'

class DateTimeTest < Minitest::Spec

  include TimingStuff

  test "returns DateTime instances" do
    noon = DateTime.civil(2011, 3, 26, 11, 42, 36).solar_noon(-105.0)
    assert_instance_of DateTime, noon
  end

  test "DST time - 2011-03-26 11:42:36 MDT at -105.0" do
    noon = DateTime.civil(2011, 3, 26, 11, 42, 36).solar_noon(-105.0)
    assert_within_one_minute DateTime.civil(2011, 3, 26, 19, 5, 00, 'UTC'), noon
  end

  test "UTC time - 2001-06-12 19:18:15 UTC at 82.5" do
    noon = DateTime.civil(2001, 6, 12, 19, 18, 15, "UTC").solar_noon(82.5)
    assert_within_one_minute DateTime.civil(2001, 6, 12, 6, 29, 00, 'UTC'), noon
  end

  test "future time - 2031-11-28 05:07:26 MDT at 132.2" do
    noon = DateTime.civil(2031, 11, 28, 5, 7, 26, "MDT").solar_noon(132.2)
    assert_within_one_minute DateTime.civil(2031, 11, 28, 2, 59, 00, 'UTC'), noon
  end

end
