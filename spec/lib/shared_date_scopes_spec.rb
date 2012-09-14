require 'spec_helper'

class Widget < ActiveRecord::Base
  include ::DateScopes
end

describe 'Shared Date Scopes' do

  it_should_behave_like 'shared date scopes' do
    let(:kind) { Widget }
  end

end
