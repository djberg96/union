require 'union'
require 'rspec'

RSpec.describe Union do
  before(:all) do
    described_class.new('Human', :name, :age, :height)
  end

  before do
    @union = Union::Human.new
  end

  example "union_version" do
    expect(Union::VERSION).to eq('1.2.0')
    expect(Union::VERSION).to be_frozen
  end

  example "union_constructor" do
    expect{ Union::Human.new('Matz') }.to raise_error(ArgumentError)
  end

  example "union_attribute_assignment_basic" do
    expect{ @union.name = 'Daniel' }.not_to raise_error
    expect(@union.name).to eq('Daniel')
  end

  example "union_attribute_assignment_by_method_name" do
    expect{ @union.name = 'Daniel' }.not_to raise_error
    expect{ @union.age = 38 }.not_to raise_error
    expect(@union.name).to be_nil
    expect(@union.height).to be_nil
    expect(@union.age).to eq(38)
  end

  example "union_attribute_assignment_by_string_ref" do
    expect{ @union['name'] = 'Daniel' }.not_to raise_error
    expect{ @union['age'] = 38 }.not_to raise_error
    expect(@union['name']).to be_nil
    expect(@union['height']).to be_nil
    expect(@union['age']).to eq(38)
  end

  example "union_attribute_assignment_by_symbol_ref" do
    expect{ @union[:name] = 'Daniel' }.not_to raise_error
    expect{ @union[:age] = 38 }.not_to raise_error
    expect(@union[:name]).to be_nil
    expect(@union[:height]).to be_nil
    expect(@union[:age]).to eq(38)
  end
end
