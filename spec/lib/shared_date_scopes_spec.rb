require 'spec_helper'

class Widget < ActiveRecord::Base
  include ::SimpleDateScopes
end

describe 'Simple Date Scopes' do

  it_should_behave_like 'simple date scopes' do
    let(:kind) { Widget }
  end

end
