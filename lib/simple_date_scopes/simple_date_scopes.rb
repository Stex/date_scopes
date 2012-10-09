require 'active_record'

module ActiveRecord
  module Acts
    module SimpleDateScopes

      DEFAULT_FIELD = :created_at

      def self.included(base_class)
        base_class.extend(ClassMethods)
      end

      module ClassMethods

        def acts_as_date_scopes_on(field = DEFAULT_FIELD)

          scope :yesterday, -> { in_x_of(Date.today - 1.day, field, :day) }
          scope :today,     -> { in_x_of(Date.today, field, :day) }
          scope :tomorrow,  -> { in_x_of(Date.today + 1.day, field, :day) }

          scope :in_week_of, ->(date) { in_x_of(date, field, :week) }
          scope :last_week, -> { in_week_of(Date.today - 7.days) }
          scope :this_week, -> { in_week_of(Date.today) }
          scope :next_week, -> { in_week_of(Date.today + 7.days) }

          scope :in_month_of, ->(date) { in_x_of(date, field, :month) }
          scope :last_month, -> { in_month_of(Date.today - 1.months) }
          scope :this_month, -> { in_month_of(Date.today) }
          scope :next_month, -> { in_month_of(Date.today + 1.months) }

          scope :in_year_of, ->(date) { in_x_of(date, field, :year) }
          scope :last_year, -> { in_year_of(Date.today - 1.years) }
          scope :this_year, -> { in_year_of(Date.today) }
          scope :next_year, -> { in_year_of(Date.today + 1.years) }

          # extend SimpleDateScopes::SingletonMethods
          # include SimpleDateScopes::InstanceMethods

        end

        def acts_as_date_scopes
          acts_as_date_scopes_on DEFAULT_FIELD
        end

        private
        def in_x_of(date, field, method)
          where("#{field.to_s} BETWEEN ? AND ?",
                date.send("beginning_of_#{method.to_s}".to_sym).beginning_of_day,
                date.send("end_of_#{method.to_s}".to_sym).end_of_day)
        end
      end

      # module InstanceMethods
      # end

      # module SingletonMethods
      # end

    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::SimpleDateScopes)
