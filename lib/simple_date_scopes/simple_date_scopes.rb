require 'active_record'

module SimpleDateScopes

  def self.included(base_class)

    base_class.extend(ClassMethods)

    base_class.class_eval do

      base_class.extend(InstanceMethods)

      scope :in_week_of, ->(d,field = 'created_at') { in_x_of(d, field, :week) }
      scope :last_week, ->(f = 'created_at') { in_week_of(Date.today - 7.days, f) }
      scope :this_week, ->(f = 'created_at') { in_week_of(Date.today, f) }
      scope :next_week, ->(f = 'created_at') { in_week_of(Date.today + 7.days, f) }

      scope :in_month_of, ->(d,field = 'created_at') { in_x_of(d, field, :month) }
      scope :last_month, ->(f = 'created_at') { in_month_of(Date.today - 1.months, f) }
      scope :this_month, ->(f = 'created_at') { in_month_of(Date.today, f) }
      scope :next_month, ->(f = 'created_at') { in_month_of(Date.today + 1.months, f) }

      scope :in_year_of, ->(d,field = 'created_at') { in_x_of(d, field, :year) }
      scope :last_year, ->(f = 'created_at') { in_year_of(Date.today - 1.years, f) }
      scope :this_year, ->(f = 'created_at') { in_year_of(Date.today, f) }
      scope :next_year, ->(f = 'created_at') { in_year_of(Date.today + 1.years, f) }

    end
  end

  module ClassMethods
    private
    def in_x_of(date, field, method)
      where("#{field} BETWEEN ? AND ?",
            date.send("beginning_of_#{method.to_s}".to_sym).beginning_of_day,
            date.send("end_of_#{method.to_s}".to_sym).end_of_day)
    end
  end

  module InstanceMethods
  end

end
