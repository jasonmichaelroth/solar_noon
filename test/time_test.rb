require 'minitest_helper'
require 'timing_helper'
require 'solar_noon'

class TimeTest < Minitest::Spec

  include TimingStuff

  test "converts Time to DateTime" do
    converted = Time.utc(2011, 3, 29, 10, 45, 05).to_datetime
    converted.must_equal DateTime.civil(2011, 3, 29, 10, 45, 05, "UTC")
  end

  test "jd returns a Date" do
    Time.now.jd.must_equal Date.today.jd
  end

  test "returns Time instances" do
    noon = Time.local(2011, 3, 26, 11, 42, 36).solar_noon(-105.0)
    assert_instance_of Time, noon
  end

  test "DST time - 2011-03-26 11:42:36 MDT at -105.0" do
    noon = Time.local(2011, 3, 26, 11, 42, 36).solar_noon(-105.0)
    assert_within_one_minute Time.utc(2011, 3, 26, 19, 5, 00), noon
  end

  test "UTC time - 2001-06-12 19:18:15 UTC at 82.5" do
    noon = Time.utc(2001, 6, 12, 19, 18, 15).solar_noon(82.5)
    assert_within_one_minute Time.utc(2001, 6, 12, 6, 29, 00), noon
  end

  test "future time - 2031-11-28 05:07:26 MDT at 132.2" do
    noon = Time.utc(2031, 11, 28, 5, 7, 26).solar_noon(132.2)
    assert_within_one_minute Time.utc(2031, 11, 28, 2, 59, 00), noon
  end

end
