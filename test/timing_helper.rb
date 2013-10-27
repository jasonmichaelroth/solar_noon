module TimingStuff
  def assert_within_one_minute(expected, actual)
    flunk "#{actual.inspect} is not a Time or DateTime instance" unless [DateTime, Time].include? actual.class
    flunk "#{expected.inspect} is not a Time or DateTime instance" unless [DateTime, Time].include? expected.class
    flunk "#{actual.inspect} is not the same class as #{expected.inspect}" unless expected.is_a? actual.class

    diff = actual - expected
    diff = (diff.to_f * 24 * 60 * 60) if diff.is_a? Rational

    flunk "#{actual} is not within one minute of #{expected}" unless diff.abs <= 60
  end
end
