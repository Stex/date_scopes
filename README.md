# LessSimpleDateScopes

A super tiny gem that provides basic year, month and week scopes.
It allows a little more customization than the original [SimpleDateScopes](https://github.com/speartail/date_scopes). 

## Installation

Add this line to your application's Gemfile:

    gem 'less_simple_date_scopes'

And then execute:

    $ bundle

## Usage

```ruby
class OtherWidget < ActiveRecord::Base
  simple_date_scopes_on :produced_at
end
```

Your ActiveRecord based models will now have the following automatic scopes:

* last\_year, this\_year, next\_year
* last\_month, this\_month, next\_month
* last\_week, this\_week, next\_week
* yesterday, today, tomorrow

There are also utility scopes:

* in\_year\_of [date]
* in\_month\_of [date]
* in\_week\_of [date]

This means the following will work:

```ruby
Widget.this_month.all.each do |w|
  puts w.to_s
end

Widget.last_month.all(:limit => 4).each do |w|
  puts w.to_s
end

Widget.in_month_of(Date.new(2012, 2, 7)).all.each do |w|
  puts w.to_s
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
