shared_examples_for 'simple date scopes' do |kind,field|

  before :each do
    @count = 4
    @count.times { FactoryGirl.create kind.name.underscore.to_sym }
    @old_item = kind.first
    @new_item = kind.last
    field ||= ActiveRecord::Acts::SimpleDateScopes::DEFAULT_FIELD
  end

  it 'should have 4 items' do
    kind.count.should eq(4)
  end

  it 'should support last_year, this_year and next_year' do
    @old_item.update_attribute field, Time.now - 1.years
    @new_item.update_attribute field, Time.now + 1.years
    kind.last_year.count.should eq(1)
    kind.this_year.count.should eq(2)
    kind.next_year.count.should eq(1)
  end

  it 'should support last_month, this_month and next_month' do
    @old_item.update_attribute field, Time.now - 1.months
    @new_item.update_attribute field, Time.now + 1.months
    kind.last_month.count.should eq(1)
    kind.this_month.count.should eq(2)
    kind.next_month.count.should eq(1)
  end

  it 'should support last_week, this_week and next_week' do
    @old_item.update_attribute field, Time.now - 1.weeks
    @new_item.update_attribute field, Time.now + 1.weeks
    kind.last_week.count.should eq(1)
    kind.this_week.count.should eq(2)
    kind.next_week.count.should eq(1)
  end

  it 'should support yesterday, today and tomorrow' do
    @old_item.update_attribute field, Time.now - 1.day
    @new_item.update_attribute field, Time.now + 1.day
    kind.yesterday.count.should eq(1)
    kind.today.count.should eq(2)
    kind.tomorrow.count.should eq(1)
  end

  describe 'in_(week|month|year)_of' do

    let(:date) { Date.today - 3.years }

    before :each do
      @old_item.update_attribute field, date
    end

    it 'should support in_year_of' do
      kind.in_year_of(date).length.should eq(1)
    end

    it 'should support in_month_of' do
      kind.in_month_of(date).length.should eq(1)
    end

    it 'should support in_week_of' do
      kind.in_week_of(date).length.should eq(1)
    end

  end

  describe 'handling days' do

    it 'should work in the past' do
      Timecop.travel(Date.today.beginning_of_day - 1.day) do
        kind.yesterday.count.should eq(0)
        kind.today.count.should eq(0)
        kind.tomorrow.count.should eq(@count)
      end
    end

    it 'should work currently' do
      Timecop.travel(Date.today.beginning_of_day) do
        kind.yesterday.count.should eq(0)
        kind.today.count.should eq(@count)
        kind.tomorrow.count.should eq(0)
      end
    end

    it 'should work in the future' do
      Timecop.travel(Date.today.beginning_of_day + 1.day) do
        kind.yesterday.count.should eq(@count)
        kind.today.count.should eq(0)
        kind.tomorrow.count.should eq(0)
      end
    end

  end

  describe 'handling weeks' do

    it 'should work in the past' do
      Timecop.travel(Date.today.beginning_of_week - 1.weeks) do
        kind.last_week.count.should eq(0)
        kind.this_week.count.should eq(0)
        kind.next_week.count.should eq(@count)
      end
    end

    it 'should work currently' do
      Timecop.travel(Date.today.beginning_of_week) do
        kind.last_week.count.should eq(0)
        kind.this_week.count.should eq(@count)
        kind.next_week.count.should eq(0)
      end
    end

    it 'should work in the future' do
      Timecop.travel(Date.today.beginning_of_week + 1.weeks) do
        kind.last_week.count.should eq(@count)
        kind.this_week.count.should eq(0)
        kind.next_week.count.should eq(0)
      end
    end

  end

  describe 'handling months' do

    it 'should work in the past' do
      Timecop.travel(Date.today.beginning_of_month - 1.months) do
        kind.last_month.count.should eq(0)
        kind.this_month.count.should eq(0)
        kind.next_month.count.should eq(@count)
      end
    end

    it 'should work currently' do
      Timecop.travel(Date.today.beginning_of_month) do
        kind.last_month.count.should eq(0)
        kind.this_month.count.should eq(@count)
        kind.next_month.count.should eq(0)
      end
    end

    it 'should work in the future' do
      Timecop.travel(Date.today.beginning_of_month + 1.months) do
        kind.last_month.count.should eq(@count)
        kind.this_month.count.should eq(0)
        kind.next_month.count.should eq(0)
      end
    end

  end

  describe 'handling years' do

    it 'should work in the past' do
      Timecop.travel(Date.today.beginning_of_year - 1.years) do
        kind.last_year.count.should eq(0)
        kind.this_year.count.should eq(0)
        kind.next_year.count.should eq(@count)
      end
    end

    it 'should work currently' do
      Timecop.travel(Date.today.beginning_of_year) do
        kind.last_year.count.should eq(0)
        kind.this_year.count.should eq(@count)
        kind.next_year.count.should eq(0)
      end
    end

    it 'should work in the future' do
      Timecop.travel(Date.today.beginning_of_year + 1.years) do
        kind.last_year.count.should eq(@count)
        kind.this_year.count.should eq(0)
        kind.next_year.count.should eq(0)
      end
    end

  end
end
