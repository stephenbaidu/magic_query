require 'spec_helper'

describe 'Parser' do
  describe '#valid?' do
    queries = {
      'first_name.is John' => true,
      'age.lteq 20' => true,
      'age.lte 20' => false,
      'height.in 1..5' => true
    }

    queries.each do |query, expected|
      it 'checks if query is valid' do
        expect(MagicQuery::Parser.new(query).valid?).to eq(expected)
      end
    end
  end

  describe '#matched?' do
    values = {
      first_name: 'John',
      'age' => 19,
      height: 21,
      'name': 'John Doe'
    }

    queries = {
      'first_name.is John' => true,
      'first_name.eq John' => false,
      'first_name.isnot John' => false,
      'first_name.isnot Doe' => true,
      'name.is John' => false,
      'name.is John Doe' => true,
      'age.lteq 20' => true,
      'height.in 1..5' => false,
      'height.in 20..25' => true
    }

    queries.each do |query, expected|
      it "checks if '#{query}' is matched against values" do
        expect(MagicQuery::Parser.new(query).matched?(values)).to eq(expected)
      end
    end
  end
end
