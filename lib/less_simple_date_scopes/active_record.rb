module LessSimpleDateScopes
  module ActiveRecord
    DEFAULT_FIELD = :created_at

    def self.included(base_class)
      base_class.extend(ClassMethods)
    end

    module ClassMethods

      #
      # Generates some named scopes in the current model which allow
      # easy date based access on records for often needed tasks.
      #
      # @param [String, Symbol] field
      #   The table column (date or datetime) the scopes will be running on
      #
      # @param [Hash] options
      #   Options to customize the generated scopes
      #
      # @option options [String] :table_name (ActiveRecord::Base.table_name)
      #   The table name the scopes will be running on. This is useful
      #   if the scope is used to filter based on an association rather than
      #   on the model's own table
      #
      # @option options [String] :prefix (nil)
      #   An optional prefix for the generated scope name. Useful if
      #   there are generated scopes for two tables which share the same
      #   column name (e.g. +generated_at+)
      #
      def simple_date_scopes_on(field, options = {})
        table_name = options.delete(:table_name) || self.table_name
        prefix     = options.delete(:prefix)

        named_scope acts_as_date_scope_name(field, :yesterday, prefix),   lambda { in_x_of(table_name, Time.zone.now - 1.day, field, :day, options) }
        named_scope acts_as_date_scope_name(field, :today, prefix),       lambda { in_x_of(table_name, Time.zone.now, field, :day, options) }
        named_scope acts_as_date_scope_name(field, :tomorrow, prefix),    lambda { in_x_of(table_name, Time.zone.now + 1.day, field, :day, options) }

        named_scope acts_as_date_scope_name(field, :in_week_of, prefix),  lambda {|date| in_x_of(table_name, date, field, :week, options) }
        named_scope acts_as_date_scope_name(field, :last_week, prefix),   lambda { in_x_of(table_name, Time.zone.now - 7.days, field, :week, options) }
        named_scope acts_as_date_scope_name(field, :this_week, prefix),   lambda { in_x_of(table_name, Time.zone.now, field, :week, options) }
        named_scope acts_as_date_scope_name(field, :next_week, prefix),   lambda { in_x_of(table_name, Time.zone.now + 7.days, field, :week, options) }

        named_scope acts_as_date_scope_name(field, :in_month_of, prefix), lambda {|date| in_x_of(table_name, date, field, :month, options) }
        named_scope acts_as_date_scope_name(field, :last_month, prefix),  lambda { in_x_of(table_name, Time.zone.now - 1.month, field, :month, options) }
        named_scope acts_as_date_scope_name(field, :this_month, prefix),  lambda { in_x_of(table_name, Time.zone.now, field, :month, options) }
        named_scope acts_as_date_scope_name(field, :next_month, prefix),  lambda { in_x_of(table_name, Time.zone.now + 1.month, field, :month, options) }

        named_scope acts_as_date_scope_name(field, :in_year_of, prefix),  lambda {|date| in_x_of(table_name, date, field, :year, options) }
        named_scope acts_as_date_scope_name(field, :last_year, prefix),   lambda { in_x_of(table_name, Time.zone.now - 1.year, field, :year, options) }
        named_scope acts_as_date_scope_name(field, :this_year, prefix),   lambda { in_x_of(table_name, Time.zone.now, field, :year, options) }
        named_scope acts_as_date_scope_name(field, :next_year, prefix),   lambda { in_x_of(table_name, Time.zone.now + 1.year, field, :year, options) }

        named_scope acts_as_date_scope_name(field, :between, prefix),
                    lambda {|s, e|
                      start_date = (s.is_a?(String) ? Time.zone.parse(s) : s).beginning_of_day
                      end_date   = (e.is_a?(String) ? Time.zone.parse(e) : e).end_of_day
                      options.merge({:conditions => {table_name => {field => (start_date..end_date)}}})
                    }
      end

      def simple_date_scopes
        simple_date_scopes_on DEFAULT_FIELD
      end

      private

      def in_x_of(table_name, date, field, method, options)
        start_date = date.send("beginning_of_#{method.to_s}").beginning_of_day
        end_date   = date.send("end_of_#{method.to_s}").end_of_day
        options.merge({:conditions => {table_name => {field => (start_date..end_date)}}})
      end

      def acts_as_date_scope_name(field, scope_name, prefix)
        [prefix, field, scope_name].compact.join('_')
      end
    end
  end
end
