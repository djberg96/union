## Description
The union library provides the Ruby analog of a C union.

## Installation
`gem install union`

## Synopsis
```ruby
require 'union'

Union.new('Human', :name, :age, :height)
h = Union::Human.new

# Only one attribute of the union may be set
h.name = 'Daniel' # => #<struct Union::Human name="Daniel", age=nil>
h.age  = 38       # => #<struct Union::Human name=nil, age=38>
```

## Known issues or bugs
None that I'm aware of. Please report any bugs you find on the project
page at on the github project page at https://github.com/djberg96/union.

## License
Artistic-2.0

## Copyright
(C) 2003-2021 Daniel J. Berger
All Rights Reserved.

## Warranty
This package is provided "as is" and without any express or
implied warranties, including, without limitation, the implied
warranties of merchantability and fitness for a particular purpose.

## Author
Daniel J. Berger
