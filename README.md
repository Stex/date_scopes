# DateScopes

A super tiny gem that provides basic year, month and week scopes.

## TODO

* More specs
* Add support for specifying another field instead of :created\_at

## Installation

Add this line to your application's Gemfile:

    gem 'date_scopes'

And then execute:

    $ bundle

If you want to test that your models are using it properly, you can do:

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
