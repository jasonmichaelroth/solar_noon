require 'minitest_helper'
require 'core-ext/time'

class TimeExtensionsTest < Minitest::Spec

  test "converts Time to DateTime" do
    converted = Time.utc(2011, 3, 29, 10, 45, 05).to_datetime
    converted.must_equal DateTime.civil(2011, 3, 29, 10, 45, 05, "UTC")
  end

  test "jd returns a Date" do
    Time.now.jd.must_equal Date.today.jd
  end

end
