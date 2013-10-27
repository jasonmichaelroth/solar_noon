# Solar Noon Calculator

[![Build Status](https://travis-ci.org/jasonmichaelroth/solar_noon.png?branch=master)](https://travis-ci.org/jasonmichaelroth/solar_noon)

Finds "solar noon" for a given day and longitude. Extends `Time`, `Date` and `DateTime` classes with a `#solar_noon` method.

Based on the [NOAA solar noon calculator](http://www.esrl.noaa.gov/gmd/grad/solcalc/).


## Usage

```ruby
require 'solar_noon'

Date.today.solar_noon(-105.1)
#=> #<DateTime: 2013-10-27T18:44:13+00:00 ((2456593j,67453s,(471258705078125/2097152)n),+0s,2299161j)>

DateTime.now.solar_noon(-105.1)
#=> #<DateTime: 2013-10-27T18:44:13+00:00 ((2456593j,67453s,(471258705078125/2097152)n),+0s,2299161j)>

Time.now.solar_noon(-105.1)
#=> #<DateTime: 2013-10-27T18:44:13+00:00 ((2456593j,67453s,(471258705078125/2097152)n),+0s,2299161j)>
```


## Tests

```
$ bundle exec rake test
```


## History

1.0.0

- released
