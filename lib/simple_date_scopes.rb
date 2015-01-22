require 'simple_date_scopes/version'
require 'simple_date_scopes/simple_date_scopes'

module SimpleDateScopes
end

ActiveRecord::Base.class_eval do
  include SimpleDateScopes
end

