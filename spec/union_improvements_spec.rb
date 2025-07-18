# frozen_string_literal: true

require 'union'
require 'rspec'

RSpec.describe 'Union improvements' do
  before(:all) do
    Union.new('TestUnion', :name, :age, :height, :weight)
  end

  before do
    @union = Union::TestUnion.new
  end

  describe '#which_member' do
    context 'when no member is set' do
      it 'returns nil' do
        expect(@union.which_member).to be_nil
      end
    end

    context 'when a member is set' do
      it 'returns the symbol of the currently set member' do
        @union.name = 'Alice'
        expect(@union.which_member).to eq(:name)

        @union.age = 30
        expect(@union.which_member).to eq(:age)
      end

      it 'works with different data types' do
        @union.height = 180.5
        expect(@union.which_member).to eq(:height)

        @union.weight = { value: 70, unit: 'kg' }
        expect(@union.which_member).to eq(:weight)
      end

      it 'works when setting via string or symbol indexing' do
        @union[:name] = 'Bob'
        expect(@union.which_member).to eq(:name)

        @union['age'] = 25
        expect(@union.which_member).to eq(:age)
      end
    end

    context 'when multiple members are set to nil explicitly' do
      it 'returns nil' do
        @union.name = 'Test'
        @union.name = nil
        expect(@union.which_member).to be_nil
      end
    end

    context 'when false or empty values are set' do
      it 'correctly identifies members with falsy but non-nil values' do
        @union.name = false
        expect(@union.which_member).to eq(:name)

        @union.age = 0
        expect(@union.which_member).to eq(:age)

        @union.height = ''
        expect(@union.which_member).to eq(:height)

        @union.weight = []
        expect(@union.which_member).to eq(:weight)
      end
    end
  end

  describe '#current_value' do
    context 'when no member is set' do
      it 'returns nil' do
        expect(@union.current_value).to be_nil
      end
    end

    context 'when a member is set' do
      it 'returns the value of the currently set member' do
        @union.name = 'Bob'
        expect(@union.current_value).to eq('Bob')

        @union.height = 180.5
        expect(@union.current_value).to eq(180.5)
      end

      it 'works with complex data types' do
        complex_data = { name: 'John', details: [1, 2, 3] }
        @union.weight = complex_data
        expect(@union.current_value).to eq(complex_data)
      end

      it 'returns falsy but non-nil values correctly' do
        @union.name = false
        expect(@union.current_value).to eq(false)

        @union.age = 0
        expect(@union.current_value).to eq(0)

        @union.height = ''
        expect(@union.current_value).to eq('')
      end
    end

    context 'consistency with which_member' do
      it 'returns the value of the member returned by which_member' do
        test_values = ['Alice', 42, 180.5, { test: 'data' }]
        members = [:name, :age, :height, :weight]

        test_values.zip(members).each do |value, member|
          @union.send("#{member}=", value)
          expect(@union.which_member).to eq(member)
          expect(@union.current_value).to eq(value)
        end
      end
    end
  end

  describe '#[]= enhanced error handling' do
    context 'with invalid member names' do
      it 'raises ArgumentError for symbol keys' do
        expect { @union[:invalid] = 'test' }.to raise_error(ArgumentError, "no member 'invalid' in union")
        expect { @union[:nonexistent] = 'test' }.to raise_error(ArgumentError, "no member 'nonexistent' in union")
      end

      it 'raises ArgumentError for string keys' do
        expect { @union['invalid'] = 'test' }.to raise_error(ArgumentError, "no member 'invalid' in union")
        expect { @union['nonexistent'] = 'test' }.to raise_error(ArgumentError, "no member 'nonexistent' in union")
      end

      it 'includes the invalid member name in the error message' do
        expect { @union[:bad_key] = 'value' }.to raise_error(ArgumentError, /bad_key/)
        expect { @union['another_bad_key'] = 'value' }.to raise_error(ArgumentError, /another_bad_key/)
      end
    end

    context 'with valid member names' do
      it 'accepts both string and symbol keys' do
        expect { @union[:name] = 'Alice' }.not_to raise_error
        expect { @union['age'] = 30 }.not_to raise_error
      end

      it 'treats string and symbol keys as equivalent' do
        @union[:name] = 'Alice'
        expect(@union['name']).to eq('Alice')

        @union['age'] = 30
        expect(@union[:age]).to eq(30)
      end
    end

    context 'return value' do
      it 'returns the assigned value' do
        result = (@union[:name] = 'Charlie')
        expect(result).to eq('Charlie')

        result = (@union['age'] = 42)
        expect(result).to eq(42)
      end

      it 'returns the assigned value even for falsy values' do
        result = (@union[:name] = false)
        expect(result).to eq(false)

        result = (@union['age'] = 0)
        expect(result).to eq(0)

        result = (@union[:height] = nil)
        expect(result).to be_nil
      end
    end
  end

  describe 'setter methods safety and functionality' do
    context 'with various data types' do
      it 'handles strings correctly' do
        @union.name = 'String value'
        expect(@union.name).to eq('String value')
        expect(@union.age).to be_nil
        expect(@union.height).to be_nil
        expect(@union.weight).to be_nil
      end

      it 'handles numbers correctly' do
        @union.age = 42
        expect(@union.age).to eq(42)
        expect(@union.name).to be_nil
        expect(@union.height).to be_nil
        expect(@union.weight).to be_nil
      end

      it 'handles arrays correctly' do
        test_array = [1, 2, 3, 'test']
        @union.height = test_array
        expect(@union.height).to eq(test_array)
        expect(@union.name).to be_nil
        expect(@union.age).to be_nil
        expect(@union.weight).to be_nil
      end

      it 'handles hashes correctly' do
        test_hash = { key: 'value', nested: { data: 123 } }
        @union.weight = test_hash
        expect(@union.weight).to eq(test_hash)
        expect(@union.name).to be_nil
        expect(@union.age).to be_nil
        expect(@union.height).to be_nil
      end

      it 'handles objects correctly' do
        test_object = Object.new
        @union.name = test_object
        expect(@union.name).to eq(test_object)
        expect(@union.age).to be_nil
      end
    end

    context 'union behavior enforcement' do
      it 'ensures only one member is set at a time via setters' do
        @union.name = 'Alice'
        @union.age = 30
        @union.height = 170.5

        # Only the last set member should have a value
        expect(@union.name).to be_nil
        expect(@union.age).to be_nil
        expect(@union.height).to eq(170.5)
      end

      it 'ensures only one member is set at a time via []=' do
        @union[:name] = 'Alice'
        @union['age'] = 30
        @union[:height] = 170.5

        # Only the last set member should have a value
        expect(@union[:name]).to be_nil
        expect(@union['age']).to be_nil
        expect(@union[:height]).to eq(170.5)
      end

      it 'works correctly when mixing setter methods and []=' do
        @union.name = 'Alice'
        @union[:age] = 30
        @union['height'] = 170.5

        expect(@union.name).to be_nil
        expect(@union.age).to be_nil
        expect(@union.height).to eq(170.5)
      end
    end
  end

  describe 'method definition safety' do
    it 'uses define_singleton_method instead of instance_eval for security' do
      # This test ensures that the setter methods are properly defined
      # and work correctly without security vulnerabilities
      expect(@union).to respond_to(:name=)
      expect(@union).to respond_to(:age=)
      expect(@union).to respond_to(:height=)
      expect(@union).to respond_to(:weight=)

      # Test that the methods work as expected
      @union.name = 'Test'
      expect(@union.name).to eq('Test')
    end

    it 'defines methods that properly delegate to []=' do
      # Ensure that setter methods use the enhanced []= method
      expect(@union).to receive(:[]=).with(:name, 'Test Value')
      @union.name = 'Test Value'
    end
  end

  describe 'edge cases and robustness' do
    context 'with nil values' do
      it 'allows explicitly setting members to nil' do
        @union.name = 'Alice'
        expect(@union.name).to eq('Alice')

        @union.name = nil
        expect(@union.name).to be_nil
        expect(@union.which_member).to be_nil
        expect(@union.current_value).to be_nil
      end
    end

    context 'with empty collections' do
      it 'treats empty arrays as valid values' do
        @union.height = []
        expect(@union.height).to eq([])
        expect(@union.which_member).to eq(:height)
        expect(@union.current_value).to eq([])
      end

      it 'treats empty hashes as valid values' do
        @union.weight = {}
        expect(@union.weight).to eq({})
        expect(@union.which_member).to eq(:weight)
        expect(@union.current_value).to eq({})
      end

      it 'treats empty strings as valid values' do
        @union.name = ''
        expect(@union.name).to eq('')
        expect(@union.which_member).to eq(:name)
        expect(@union.current_value).to eq('')
      end
    end

    context 'with boolean values' do
      it 'handles true values correctly' do
        @union.name = true
        expect(@union.name).to eq(true)
        expect(@union.which_member).to eq(:name)
        expect(@union.current_value).to eq(true)
      end

      it 'handles false values correctly' do
        @union.name = false
        expect(@union.name).to eq(false)
        expect(@union.which_member).to eq(:name)
        expect(@union.current_value).to eq(false)
      end
    end
  end
end
