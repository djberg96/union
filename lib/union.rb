# frozen_string_literal: true

# The Union class provides an analogue of a C union. Only one member of
# a Union object can be set to a non-nil value at a time.
#
class Union < Struct
  # The version of the union library
  VERSION = '1.2.0'

  # Creates and returns a new Union. Unlike Struct::Class.new, this does not
  # take any arguments. You must assign attributes individually.
  #
  #    Union.new('Human', :name, :age)
  #    h = Union::Human.new
  #
  #    h.name = 'Daniel' # => #<struct Union::Human name="Daniel", age=nil>
  #    h.age  = 38       # => #<struct Union::Human name=nil, age=38>
  #--
  # The semantics of Union.new(arg1, arg2, ...) would be non-sensical. Which
  # attribute should be set while the rest are ignored? The first one or the
  # last one? I decided to disallow it altogether.
  #
  def initialize
    super
    members.each do |attribute|
      m = %{
        def #{attribute}=(value)
          self['#{attribute}'] = value
        end
      }
      instance_eval(m)
    end
  end

  # Identical to Struct attribute assignment, except that setting one instance
  # variable sets all other instance variables to nil. Also, you cannot use a
  # numeric index. You must use a string or symbol.
  #
  #    Union.new('Human', :name, :age)
  #    h = Union::Human.new
  #
  #    h[:name] = 'Daniel' # => #<struct Union::Human name="Daniel", age=nil>
  #    h[:age]  = 38       # => #<struct Union::Human name=nil, age=38>
  #
  def []=(symbol, value)
    super
    members.each{ |m| super(m, nil) unless m.to_s == symbol.to_s }
  end
end
