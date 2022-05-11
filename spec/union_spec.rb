# frozen_string_literal: true

require 'union'
require 'rspec'

RSpec.describe Union do
  before(:all) do
    described_class.new('Human', :name, :age, :height)
  end

  before do
    @union = Union::Human.new
  end

  example 'VERSION constant is set to expected value' do
    expect(Union::VERSION).to eq('1.2.0')
    expect(Union::VERSION).to be_frozen
  end

  example 'constructor does not accept arguments' do
    expect{ Union::Human.new('Matz') }.to raise_error(ArgumentError)
  end

  example 'basic union attribute assignment functionality' do
    expect{ @union.name = 'Daniel' }.not_to raise_error
    expect(@union.name).to eq('Daniel')
  end

  example 'union attributes via method are set to expected value' do
    expect{ @union.name = 'Daniel' }.not_to raise_error
    expect{ @union.age = 38 }.not_to raise_error
    expect(@union.name).to be_nil
    expect(@union.height).to be_nil
    expect(@union.age).to eq(38)
  end

  example 'union attributes via string ref are set to expected value' do
    expect{ @union['name'] = 'Daniel' }.not_to raise_error
    expect{ @union['age'] = 38 }.not_to raise_error
    expect(@union['name']).to be_nil
    expect(@union['height']).to be_nil
    expect(@union['age']).to eq(38)
  end

  example 'union attributes via symbol ref are set to expected value' do
    expect{ @union[:name] = 'Daniel' }.not_to raise_error
    expect{ @union[:age] = 38 }.not_to raise_error
    expect(@union[:name]).to be_nil
    expect(@union[:height]).to be_nil
    expect(@union[:age]).to eq(38)
  end
end
