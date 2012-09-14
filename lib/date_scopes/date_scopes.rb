require 'active_record'

module DateScopes

  def self.included(base_class)

    #include the new methods into this class
    base_class.extend(ClassMethods)

    base_class.class_eval do
      base_class.extend(InstanceMethods)

      scope :in_week_of, lambda { |d| where('created_at BETWEEN ? AND ?', 
                                            d.beginning_of_week,
                                            d.end_of_week ) }
      scope :last_week, lambda { in_week_of(Date.today - 1.weeks) }
      scope :this_week, lambda { in_week_of(Date.today) }
      scope :next_week, lambda { in_week_of(Date.today + 1.weeks) }

      scope :in_month_of, lambda { |d| where('created_at BETWEEN ? AND ?',
                                             d.beginning_of_month,
                                             d.end_of_month ) }
      scope :last_month, lambda { in_month_of(Date.today - 1.months) }
      scope :this_month, lambda { in_month_of(Date.today) }
      scope :next_month, lambda { in_month_of(Date.today + 1.months) }

      scope :in_year_of, lambda { |d| where('created_at BETWEEN ? AND ?',
                                             d.beginning_of_year,
                                             d.end_of_year ) }
      scope :last_year, lambda { in_year_of(Date.today - 1.years) }
      scope :this_year, lambda { in_year_of(Date.today) }
      scope :next_year, lambda { in_year_of(Date.today + 1.years) }
    end
  end
 
  module ClassMethods
 
    # def some_class_method?
    #   1 > 0
    # end
   
  end

  module InstanceMethods
  end

end
