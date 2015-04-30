# LessSimpleDateScopes

A super tiny gem that provides basic year, month and week scopes.
It allows a little more customization than the original [SimpleDateScopes](https://github.com/speartail/date_scopes). 

## Installation

Add this line to your application's Gemfile:

    gem 'less_simple_date_scopes'

And then execute:

    $ bundle

## Usage

You can add a set of predefined date scopes for a certain database column by 
calling `simple_date_scopes_on` in the corresponding model:

```ruby
class Booking < ActiveRecord::Base
  simple_date_scopes_on :created_at
end
```

This will generate the following groups of scopes:

**Relative Date Scopes**

* last\_year, this\_year, next\_year
* last\_month, this\_month, next\_month
* last\_week, this\_week, next\_week
* yesterday, today, tomorrow

**Week, Month and Year Scopes**

* in\_year\_of [date]
* in\_month\_of [date]
* in\_week\_of [date]

**Range Scopes**

* between [start_date] [end_date]

Start and end date may either be Date (or DateTime) objects or Strings Date.parse() can handle.

## Examples

```ruby
Booking.created_at_this_month.all.each do |w|
  puts w.to_s
end

Widget.created_at_last_month.all(:limit => 4).each do |w|
  puts w.to_s
end

Booking.created_at_in_month_of(Date.new(2012, 2, 7)).all.each do |w|
  puts w.to_s
end

Booking.created_at_in_month_of('2012-03-25').all.each do |w|
  puts w.to_s
end
```

## Naming

All scopes are prefixed with the field they were defined on, in this case `created_at`.
If you need another custom prefix, you may specify it by passing in `:prefix` to `simple_date_scopes_on` as
second argument:

```ruby
simple_date_scopes_on :created_at, :prefix => 'scoped'
```

This would generate scope names in the format `scoped_created_at_...`

## Custom Tables

Sometimes it might be useful to generate date scopes for an associated model/table,
e.g. for sorting purposes. The table name used by the scope can be passed in with `:table_name`:

```ruby
simple_date_scopes_on :created_at, :table_name => 'booking_position', :prefix => 'booking_position'
```

This would generate scopes of the format `booking_position_created_at_...`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
