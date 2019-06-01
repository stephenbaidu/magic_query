require 'spec_helper'

describe 'VERSION' do
  it 'has a version number' do
    expect(MagicQuery::VERSION).not_to be nil
  end
end
