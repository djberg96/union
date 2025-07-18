# frozen_string_literal: true

require 'union'
require 'rspec'

RSpec.describe 'Union improvements' do
  before(:all) do
    Union.new('TestUnion', :name, :age, :height)
  end

  before do
    @union = Union::TestUnion.new
  end

  describe '#which_member' do
    it 'returns nil when no member is set' do
      expect(@union.which_member).to be_nil
    end

    it 'returns the symbol of the currently set member' do
      @union.name = 'Alice'
      expect(@union.which_member).to eq(:name)

      @union.age = 30
      expect(@union.which_member).to eq(:age)
    end
  end

  describe '#current_value' do
    it 'returns nil when no member is set' do
      expect(@union.current_value).to be_nil
    end

    it 'returns the value of the currently set member' do
      @union.name = 'Bob'
      expect(@union.current_value).to eq('Bob')

      @union.height = 180.5
      expect(@union.current_value).to eq(180.5)
    end
  end

  describe '#[]= error handling' do
    it 'raises ArgumentError for invalid member names' do
      expect { @union[:invalid] = 'test' }.to raise_error(ArgumentError, "no member 'invalid' in union")
      expect { @union['nonexistent'] = 'test' }.to raise_error(ArgumentError, "no member 'nonexistent' in union")
    end

    it 'returns the assigned value' do
      result = (@union[:name] = 'Charlie')
      expect(result).to eq('Charlie')
    end
  end

  describe 'setter methods safety' do
    it 'works with various data types' do
      @union.name = 'String value'
      expect(@union.name).to eq('String value')

      @union.age = 42
      expect(@union.age).to eq(42)
      expect(@union.name).to be_nil

      @union.height = [1, 2, 3]
      expect(@union.height).to eq([1, 2, 3])
      expect(@union.age).to be_nil
    end
  end
end
