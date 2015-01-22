module SimpleDateScopes

  DEFAULT_FIELD = :created_at

  def self.included(base_class)
    base_class.extend(ClassMethods)
  end

  module ClassMethods

    def simple_date_scopes_on(field = DEFAULT_FIELD)
      named_scope acts_as_date_scope_name(field, :yesterday),  lambda { in_x_of(Date.today - 1.day, field, :day) }
      named_scope acts_as_date_scope_name(field, :today),      lambda { in_x_of(Date.today, field, :day) }
      named_scope acts_as_date_scope_name(field, :tomorrow),   lambda { in_x_of(Date.today + 1.day, field, :day) }

      named_scope acts_as_date_scope_name(field, :in_week_of), lambda {|date| in_x_of(date, field, :week) }
      named_scope acts_as_date_scope_name(field, :last_week),  lambda { in_x_of(Date.today - 7.days, field, :week) }
      named_scope acts_as_date_scope_name(field, :this_week),  lambda { in_x_of(Date.today, field, :week) }
      named_scope acts_as_date_scope_name(field, :next_week),  lambda { in_x_of(Date.today + 7.days, field, :week) }

      named_scope acts_as_date_scope_name(field, :in_month_of), lambda {|date| in_x_of(date, field, :month) }
      named_scope acts_as_date_scope_name(field, :last_month),  lambda { in_x_of(Date.today - 1.months, field, :month) }
      named_scope acts_as_date_scope_name(field, :this_month),  lambda { in_x_of(Date.today, field, :month) }
      named_scope acts_as_date_scope_name(field, :next_month),  lambda { in_x_of(Date.today + 1.months, field, :month) }

      named_scope acts_as_date_scope_name(field, :in_year_of),  lambda {|date| in_x_of(date, field, :year) }
      named_scope acts_as_date_scope_name(field, :last_year),   lambda { in_x_of(Date.today - 1.years, field, :year) }
      named_scope acts_as_date_scope_name(field, :this_year),   lambda { in_x_of(Date.today, field, :year) }
      named_scope acts_as_date_scope_name(field, :next_year),   lambda { in_x_of(Date.today + 1.years, field, :year) }
    end

    def simple_date_scopes
      simple_date_scopes_on DEFAULT_FIELD
    end

    private
    def in_x_of(date, field, method)
      {
          :conditions => ["#{field} BETWEEN ? AND ?", date.send("beginning_of_#{method.to_s}").beginning_of_day,
                                                      date.send("end_of_#{method.to_s}").end_of_day]
      }
    end

    def acts_as_date_scope_name(field, scope_name)
      "#{field}_#{scope_name}".to_sym
    end
  end

  # module InstanceMethods
  # end

  # module SingletonMethods
  # end

end

