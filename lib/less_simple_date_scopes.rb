require 'less_simple_date_scopes/version'
require 'less_simple_date_scopes/active_record'

module LessSimpleDateScopes
end

ActiveRecord::Base.class_eval do
  include LessSimpleDateScopes::ActiveRecord
end

