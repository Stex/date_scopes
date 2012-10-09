require 'spec_helper'

class Widget < ActiveRecord::Base
  acts_as_date_scopes_on :updated_at
end

class DefaultWidget < ActiveRecord::Base
  acts_as_date_scopes
end

describe 'Simple Date Scopes' do

  it_should_behave_like 'simple date scopes' do
    let(:kind) { Widget }
    let(:field) { :updated_at }
  end

  it_should_behave_like 'simple date scopes' do
    let(:kind) { DefaultWidget }
    let(:field) { :created_at }
  end

end
