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
    define_union_setters
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
    # Validate that the symbol is a valid member
    symbol_str = symbol.to_s
    unless members.any? { |m| m.to_s == symbol_str }
      raise ArgumentError, "no member '#{symbol}' in union"
    end

    # Set the value for the specified member
    super(symbol, value)

    # Clear all other members
    members.each { |m| super(m, nil) unless m.to_s == symbol_str }

    value
  end

  # Returns the name of the currently set member (the one with a non-nil value)
  # Returns nil if no member is set
  #
  #    Union.new('Human', :name, :age)
  #    h = Union::Human.new
  #    h.name = 'Daniel'
  #    h.which_member # => :name
  #
  def which_member
    members.find { |member| !self[member].nil? }
  end

  # Returns the current value (the value of the non-nil member)
  # Returns nil if no member is set
  #
  #    Union.new('Human', :name, :age)
  #    h = Union::Human.new
  #    h.name = 'Daniel'
  #    h.current_value # => 'Daniel'
  #
  def current_value
    member = which_member
    member ? self[member] : nil
  end

  private

  # Define setter methods for each union member using define_singleton_method
  # This is safer and more efficient than instance_eval with string interpolation
  def define_union_setters
    members.each do |attribute|
      define_singleton_method("#{attribute}=") do |value|
        self[attribute] = value
      end
    end
  end
end
