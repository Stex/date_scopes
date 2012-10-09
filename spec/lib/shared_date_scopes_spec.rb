require 'spec_helper'

class Widget < ActiveRecord::Base
  acts_as_date_scopes_on :updated_at
end

class DefaultWidget < ActiveRecord::Base
  acts_as_date_scopes
end

describe 'Simple Date Scopes' do

  it_should_behave_like 'simple date scopes', Widget, :updated_at

  it_should_behave_like 'simple date scopes', DefaultWidget

end
