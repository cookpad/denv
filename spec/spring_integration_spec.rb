require 'spec_helper'

RSpec.describe 'Spring integration' do
  specify '`Spring.watch` exists' do
    expect(Spring.respond_to?(:watch)).to be_truthy
  end
end
