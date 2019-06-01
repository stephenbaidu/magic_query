require 'spec_helper'

describe MagicQuery do
  describe '.valid?' do
    let(:parser) { instance_double('Parser', valid?: true) }

    before do
      expect(MagicQuery::Parser).to receive(:new).and_return(parser)
    end

    it 'does something' do
      expect(MagicQuery.valid?('some query')).to eq(true)
    end
  end

  describe '.matched?' do
    let(:parser) { instance_double('Parser', matched?: true) }

    before do
      expect(MagicQuery::Parser).to receive(:new).and_return(parser)
    end

    it 'does something' do
      expect(MagicQuery.matched?('some query')).to eq(true)
    end
  end
end
