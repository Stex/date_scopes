require 'active_record'

module SimpleDateScopes

  def self.included(base_class)

    base_class.extend(ClassMethods)

    base_class.class_eval do

      base_class.extend(InstanceMethods)

      scope :in_week_of, ->(d,field = 'created_at') { where("#{field} BETWEEN ? AND ?",
                                             d.beginning_of_week.beginning_of_day,
                                             d.end_of_week.end_of_day ) }
      scope :last_week, ->(f = 'created_at') { in_week_of(Date.today - 7.days, f) }
      scope :this_week, ->(f = 'created_at') { in_week_of(Date.today, f) }
      scope :next_week, ->(f = 'created_at') { in_week_of(Date.today + 7.days, f) }

      scope :in_month_of, ->(d,field = 'created_at') { where("#{field} BETWEEN ? AND ?",
                                             d.beginning_of_month.beginning_of_day,
                                             d.end_of_month.end_of_day ) }
      scope :last_month, ->(f = 'created_at') { in_month_of(Date.today - 1.months, f) }
      scope :this_month, ->(f = 'created_at') { in_month_of(Date.today, f) }
      scope :next_month, ->(f = 'created_at') { in_month_of(Date.today + 1.months, f) }

      scope :in_year_of, ->(d,field = 'created_at') { where("#{field} BETWEEN ? AND ?",
                                             d.beginning_of_year.beginning_of_day,
                                             d.end_of_year.end_of_day ) }
      scope :last_year, ->(f = 'created_at') { in_year_of(Date.today - 1.years, f) }
      scope :this_year, ->(f = 'created_at') { in_year_of(Date.today, f) }
      scope :next_year, ->(f = 'created_at') { in_year_of(Date.today + 1.years, f) }

      private
      def in_x_of(date, field, method)
      end
    end
  end

  module ClassMethods
  end

  module InstanceMethods
  end

end
