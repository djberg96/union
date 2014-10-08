require 'union'
require 'test/unit'

class TC_Union < Test::Unit::TestCase
  def setup
    Union.new('Human', :name, :age, :height) unless defined? Union::Human
    @union = Union::Human.new
  end
   
  def test_union_version
    assert_equal('1.0.4', Union::VERSION)
  end
   
  def test_union_constructor      
    assert_raise(ArgumentError){ Union::Human.new('Matz') }
  end
   
  def test_union_attribute_assignment_basic
    assert_nothing_raised{ @union.name = 'Daniel' }
    assert_equal('Daniel', @union.name)
  end
   
  def test_union_attribute_assignment_by_method_name
    assert_nothing_raised{ @union.name = 'Daniel' }
    assert_nothing_raised{ @union.age = 38 }
    assert_nil(@union.name)
    assert_nil(@union.height)
    assert_equal(38, @union.age)
  end
   
  def test_union_attribute_assignment_by_string_ref
    assert_nothing_raised{ @union['name'] = 'Daniel' }
    assert_nothing_raised{ @union['age'] = 38 }
    assert_nil(@union['name'])
    assert_nil(@union['height'])
    assert_equal(38, @union['age'])
  end
   
  def test_union_attribute_assignment_by_symbol_ref
    assert_nothing_raised{ @union[:name] = 'Daniel' }
    assert_nothing_raised{ @union[:age] = 38 }
    assert_nil(@union[:name])
    assert_nil(@union[:height])
    assert_equal(38, @union[:age])
  end         
   
  def teardown
    @union = nil
  end
end
