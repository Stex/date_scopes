module SimpleDateScopes

  DEFAULT_FIELD = :created_at

  def self.included(base_class)
    base_class.extend(ClassMethods)
  end

  module ClassMethods

    def simple_date_scopes_on(field, options = {})
      table_name = options.delete(:table_name) || self.table_name
      prefix     = options.delete(:prefix)

      named_scope acts_as_date_scope_name(table_name, field, :yesterday, prefix),  lambda { in_x_of(table_name, Date.today - 1.day, field, :day, options) }
      named_scope acts_as_date_scope_name(table_name, field, :today, prefix),      lambda { in_x_of(table_name, Date.today, field, :day, options) }
      named_scope acts_as_date_scope_name(table_name, field, :tomorrow, prefix),   lambda { in_x_of(table_name, Date.today + 1.day, field, :day, options) }

      named_scope acts_as_date_scope_name(table_name, field, :in_week_of, prefix), lambda {|date| in_x_of(table_name, date, field, :week, options) }
      named_scope acts_as_date_scope_name(table_name, field, :last_week, prefix),  lambda { in_x_of(table_name, Date.today - 7.days, field, :week, options) }
      named_scope acts_as_date_scope_name(table_name, field, :this_week, prefix),  lambda { in_x_of(table_name, Date.today, field, :week, options) }
      named_scope acts_as_date_scope_name(table_name, field, :next_week, prefix),  lambda { in_x_of(table_name, Date.today + 7.days, field, :week, options) }

      named_scope acts_as_date_scope_name(table_name, field, :in_month_of, prefix), lambda {|date| in_x_of(table_name, date, field, :month, options) }
      named_scope acts_as_date_scope_name(table_name, field, :last_month, prefix),  lambda { in_x_of(table_name, Date.today - 1.months, field, :month, options) }
      named_scope acts_as_date_scope_name(table_name, field, :this_month, prefix),  lambda { in_x_of(table_name, Date.today, field, :month, options) }
      named_scope acts_as_date_scope_name(table_name, field, :next_month, prefix),  lambda { in_x_of(table_name, Date.today + 1.months, field, :month, options) }

      named_scope acts_as_date_scope_name(table_name, field, :in_year_of, prefix),  lambda {|date| in_x_of(table_name, date, field, :year, options) }
      named_scope acts_as_date_scope_name(table_name, field, :last_year, prefix),   lambda { in_x_of(table_name, Date.today - 1.years, field, :year, options) }
      named_scope acts_as_date_scope_name(table_name, field, :this_year, prefix),   lambda { in_x_of(table_name, Date.today, field, :year, options) }
      named_scope acts_as_date_scope_name(table_name, field, :next_year, prefix),   lambda { in_x_of(table_name, Date.today + 1.years, field, :year, options) }

      named_scope acts_as_date_scope_name(table_name, field, :between, prefix),
                  lambda {|s, e|
                    start_date = (s.is_a?(String) ? Date.parse(s) : s).beginning_of_day
                    end_date   = (e.is_a?(String) ? Date.parse(e) : e).end_of_day
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

    def acts_as_date_scope_name(table_name, field, scope_name, prefix)
      [prefix, field, scope_name].compact.join('_')
    end
  end
end

