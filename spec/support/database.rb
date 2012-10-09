require 'active_record'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

# migrations
#ActiveRecord::Migrator.up "db/migrate"
ActiveRecord::Migration.create_table :widgets do |t|
  t.timestamps
end
ActiveRecord::Migration.create_table :default_widgets do |t|
  t.timestamps
end

# add missing helpers
module ActiveModel::Validations
  def errors_on(attribute)
    self.valid?
    [self.errors[attribute]].flatten.compact
  end
  alias :error_on :errors_on
end
