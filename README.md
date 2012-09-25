# DateScopes

A super tiny gem that provides basic year, month and week scopes.

[![Build Status](https://secure.travis-ci.org/speartail/date_scopes.png)](http://travis-ci.org/speartail/date_scopes)

Something like this already existed in various forms but I simply wanted to do
my own thing instead.

## Installation

Add this line to your application's Gemfile:

    gem 'date_scopes'

And then execute:

    $ bundle

If you want to test that your models are using it properly, you can do:

1. include it in spec_helper.rb
```ruby
require 'date_scopes/spec_support'
```

2. and inside your model_spec.rb
```ruby
it_should_behave_like 'shared date scopes' do
    let(:kind) { MyModelName }
end
```

## Usage

Your ActiveRecord based models will now have the following automatic scopes:

* last\_year, this\_year, next\_year
* last\_month, this\_month, next\_month
* last\_week, this\_week, next\_week

There are also utility scopes:

* in\_year\_of
* in\_month\_of
* in\_week\_of

This means the following will work:

```ruby
  Widget.this_month.each do |w|
    puts w.to_s
  end

  Widget.last_month.limit(4).each do |w|
    puts w.to_s
  end

  Widget.in_month_of(Date.new(2012, 2, 7)).each do |w|
    puts w.to_s
  end
```

We can now also take a field to use instead of :created\_at:

```ruby
  Widget.last_month(:start_production_time).limit(4).each do |w|
    puts w.to_s
  end
```

# Changes

## 0.1.1
* Refactoring to use a common private method instead of 3 almost identical methods

## 0.1.0
* Renamed to simple\_date\_scopes so we can push to rubygems

## 0.0.5-0.0.7
* Cleanups

## 0.0.4
* Fixed a nasty bug that made the scopes ignore records created on the current date
* Make the specs run properly when included
* Added support for specifying another field instead of :created\_at

## 0.0.2/3
* More specs

## 0.0.1
* Initial version

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
