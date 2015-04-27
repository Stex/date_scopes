require 'less_simple_date_scopes/version'
require 'less_simple_date_scopes/less_simple_date_scopes'

module LessSimpleDateScopes
end

ActiveRecord::Base.class_eval do
  include LessSimpleDateScopes
end

