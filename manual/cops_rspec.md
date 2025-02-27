# RSpec

## RSpec/AlignLeftLetBrace

Enabled by default | Supports autocorrection
--- | ---
Disabled | Yes

Checks that left braces for adjacent single line lets are aligned.

### Examples

```ruby
# bad
let(:foobar) { blahblah }
let(:baz) { bar }
let(:a) { b }

# good
let(:foobar) { blahblah }
let(:baz)    { bar }
let(:a)      { b }
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/AlignLeftLetBrace](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/AlignLeftLetBrace)

## RSpec/AlignRightLetBrace

Enabled by default | Supports autocorrection
--- | ---
Disabled | Yes

Checks that right braces for adjacent single line lets are aligned.

### Examples

```ruby
# bad
let(:foobar) { blahblah }
let(:baz)    { bar }
let(:a)      { b }

# good
let(:foobar) { blahblah }
let(:baz)    { bar      }
let(:a)      { b        }
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/AlignRightLetBrace](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/AlignRightLetBrace)

## RSpec/AnyInstance

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Check that instances are not being stubbed globally.

Prefer instance doubles over stubbing any instance of a class

### Examples

```ruby
# bad
describe MyClass do
  before { allow_any_instance_of(MyClass).to receive(:foo) }
end

# good
describe MyClass do
  let(:my_instance) { instance_double(MyClass) }

  before do
    allow(MyClass).to receive(:new).and_return(my_instance)
    allow(my_instance).to receive(:foo)
  end
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/AnyInstance](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/AnyInstance)

## RSpec/AroundBlock

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks that around blocks actually run the test.

### Examples

```ruby
# bad
around do
  some_method
end

around do |test|
  some_method
end

# good
around do |test|
  some_method
  test.call
end

around do |test|
  some_method
  test.run
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/AroundBlock](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/AroundBlock)

## RSpec/Be

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Check for expectations where `be` is used without argument.

The `be` matcher is too generic, as it pass on everything that is not
nil or false. If that is the exact intend, use `be_truthy`. In all other
cases it's better to specify what exactly is the expected value.

### Examples

```ruby
# bad
expect(foo).to be

# good
expect(foo).to be_truthy
expect(foo).to be 1.0
expect(foo).to be(true)
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/Be](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/Be)

## RSpec/BeEql

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Check for expectations where `be(...)` can replace `eql(...)`.

The `be` matcher compares by identity while the `eql` matcher
compares using `eql?`. Integers, floats, booleans, symbols, and nil
can be compared by identity and therefore the `be` matcher is
preferable as it is a more strict test.

This cop only looks for instances of `expect(...).to eql(...)`. We
do not check `to_not` or `not_to` since `!eql?` is more strict
than `!equal?`. We also do not try to flag `eq` because if
`a == b`, and `b` is comparable by identity, `a` is still not
necessarily the same type as `b` since the `#==` operator can
coerce objects for comparison.

### Examples

```ruby
# bad
expect(foo).to eql(1)
expect(foo).to eql(1.0)
expect(foo).to eql(true)
expect(foo).to eql(false)
expect(foo).to eql(:bar)
expect(foo).to eql(nil)

# good
expect(foo).to be(1)
expect(foo).to be(1.0)
expect(foo).to be(true)
expect(foo).to be(false)
expect(foo).to be(:bar)
expect(foo).to be(nil)
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/BeEql](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/BeEql)

## RSpec/BeforeAfterAll

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Check that before/after(:all) isn't being used.

### Examples

```ruby
# bad
#
# Faster but risk of state leaking between examples
#
describe MyClass do
  before(:all) { Widget.create }
  after(:all) { Widget.delete_all }
end

# good
#
# Slower but examples are properly isolated
#
describe MyClass do
  before(:each) { Widget.create }
  after(:each) { Widget.delete_all }
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
Exclude | `spec/spec_helper.rb`, `spec/rails_helper.rb`, `spec/support/**/*.rb` | Array

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/BeforeAfterAll](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/BeforeAfterAll)

## RSpec/ContextMethod

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

`context` should not be used for specifying methods.

### Examples

```ruby
# bad
context '#foo_bar' do
  # ...
end

context '.foo_bar' do
  # ...
end

# good
describe '#foo_bar' do
  # ...
end

describe '.foo_bar' do
  # ...
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ContextMethod](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ContextMethod)

## RSpec/ContextWording

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks that `context` docstring starts with an allowed prefix.

### Examples

#### `Prefixes` configuration

```ruby
# .rubocop.yml
# RSpec/ContextWording:
#   Prefixes:
#     - when
#     - with
#     - without
#     - if
#     - unless
#     - for
```
```ruby
# bad
context 'the display name not present' do
  # ...
end

# good
context 'when the display name is not present' do
  # ...
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
Prefixes | `when`, `with`, `without` | Array

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ContextWording](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ContextWording)

## RSpec/DescribeClass

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Check that the first argument to the top level describe is a constant.

### Examples

```ruby
# bad
describe 'Do something' do
end

# good
describe TestedClass do
end

describe "A feature example", type: :feature do
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/DescribeClass](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/DescribeClass)

## RSpec/DescribeMethod

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks that the second argument to `describe` specifies a method.

### Examples

```ruby
# bad
describe MyClass, 'do something' do
end

# good
describe MyClass, '#my_instance_method' do
end

describe MyClass, '.my_class_method' do
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/DescribeMethod](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/DescribeMethod)

## RSpec/DescribeSymbol

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Avoid describing symbols.

### Examples

```ruby
# bad
describe :my_method do
  # ...
end

# good
describe '#my_method' do
  # ...
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/DescribeSymbol](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/DescribeSymbol)

## RSpec/DescribedClass

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks that tests use `described_class`.

If the first argument of describe is a class, the class is exposed to
each example via described_class.

This cop can be configured using the `EnforcedStyle` and `SkipBlocks`
options.

There's a known caveat with rspec-rails's `controller` helper that
runs its block in a different context, and `described_class` is not
available to it. `SkipBlocks` option excludes detection in all
non-RSpec related blocks.

To narrow down this setting to only a specific directory, it is
possible to use an overriding configuration file local to that
directory.

### Examples

#### `EnforcedStyle: described_class`

```ruby
# bad
describe MyClass do
  subject { MyClass.do_something }
end

# good
describe MyClass do
  subject { described_class.do_something }
end
```
#### `EnforcedStyle: explicit`

```ruby
# bad
describe MyClass do
  subject { described_class.do_something }
end

# good
describe MyClass do
  subject { MyClass.do_something }
end
```
#### `SkipBlocks: true`

```ruby
# spec/controllers/.rubocop.yml
# RSpec/DescribedClass:
#   SkipBlocks: true

# acceptable
describe MyConcern do
  controller(ApplicationController) do
    include MyConcern
  end
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
SkipBlocks | `false` | Boolean
EnforcedStyle | `described_class` | `described_class`, `explicit`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/DescribedClass](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/DescribedClass)

## RSpec/DescribedClassModuleWrapping

Enabled by default | Supports autocorrection
--- | ---
Disabled | No

Avoid opening modules and defining specs within them.

### Examples

```ruby
# bad
module MyModule
  RSpec.describe MyClass do
    # ...
  end
end

# good
RSpec.describe MyModule::MyClass do
  # ...
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/DescribedClassModuleWrapping](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/DescribedClassModuleWrapping)

## RSpec/Dialect

Enabled by default | Supports autocorrection
--- | ---
Disabled | Yes

This cop enforces custom RSpec dialects.

A dialect can be based on the following RSpec methods:

- describe, context, feature, example_group
- xdescribe, xcontext, xfeature
- fdescribe, fcontext, ffeature
- shared_examples, shared_examples_for, shared_context
- it, specify, example, scenario, its
- fit, fspecify, fexample, fscenario, focus
- xit, xspecify, xexample, xscenario, skip
- pending
- prepend_before, before, append_before,
- around
- prepend_after, after, append_after
- let, let!
- subject, subject!
- expect, is_expected, expect_any_instance_of

By default all of the RSpec methods and aliases are allowed. By setting
a config like:

  RSpec/Dialect:
    PreferredMethods:
      context: describe

You can expect the following behavior:

### Examples

```ruby
# bad
context 'display name presence' do
  # ...
end

# good
describe 'display name presence' do
  # ...
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
PreferredMethods | `{}` | 

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/Dialect](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/Dialect)

## RSpec/EmptyExampleGroup

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks if an example group does not include any tests.

This cop is configurable using the `CustomIncludeMethods` option

### Examples

#### usage

```ruby
# bad
describe Bacon do
  let(:bacon)      { Bacon.new(chunkiness) }
  let(:chunkiness) { false                 }

  context 'extra chunky' do   # flagged by rubocop
    let(:chunkiness) { true }
  end

  it 'is chunky' do
    expect(bacon.chunky?).to be_truthy
  end
end

# good
describe Bacon do
  let(:bacon)      { Bacon.new(chunkiness) }
  let(:chunkiness) { false                 }

  it 'is chunky' do
    expect(bacon.chunky?).to be_truthy
  end
end
```
#### configuration

```ruby
# .rubocop.yml
# RSpec/EmptyExampleGroup:
#   CustomIncludeMethods:
#   - include_tests

# spec_helper.rb
RSpec.configure do |config|
  config.alias_it_behaves_like_to(:include_tests)
end

# bacon_spec.rb
describe Bacon do
  let(:bacon)      { Bacon.new(chunkiness) }
  let(:chunkiness) { false                 }

  context 'extra chunky' do   # not flagged by rubocop
    let(:chunkiness) { true }

    include_tests 'shared tests'
  end
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
CustomIncludeMethods | `[]` | Array

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyExampleGroup](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyExampleGroup)

## RSpec/EmptyLineAfterExample

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks if there is an empty line after example blocks.

### Examples

```ruby
# bad
RSpec.describe Foo do
  it 'does this' do
  end
  it 'does that' do
  end
end

# good
RSpec.describe Foo do
  it 'does this' do
  end

  it 'does that' do
  end
end

# fair - it's ok to have non-separated one-liners
RSpec.describe Foo do
  it { one }
  it { two }
end
```
#### with AllowConsecutiveOneLiners configuration

```ruby
# rubocop.yml
# RSpec/EmptyLineAfterExample:
#   AllowConsecutiveOneLiners: false

# bad
RSpec.describe Foo do
  it { one }
  it { two }
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
AllowConsecutiveOneLiners | `true` | Boolean

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyLineAfterExample](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyLineAfterExample)

## RSpec/EmptyLineAfterExampleGroup

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks if there is an empty line after example group blocks.

### Examples

```ruby
# bad
RSpec.describe Foo do
  describe '#bar' do
  end
  describe '#baz' do
  end
end

# good
RSpec.describe Foo do
  describe '#bar' do
  end

  describe '#baz' do
  end
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyLineAfterExampleGroup](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyLineAfterExampleGroup)

## RSpec/EmptyLineAfterFinalLet

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks if there is an empty line after the last let block.

### Examples

```ruby
# bad
let(:foo) { bar }
let(:something) { other }
it { does_something }

# good
let(:foo) { bar }
let(:something) { other }

it { does_something }
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyLineAfterFinalLet](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyLineAfterFinalLet)

## RSpec/EmptyLineAfterHook

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks if there is an empty line after hook blocks.

### Examples

```ruby
# bad
before { do_something }
it { does_something }

# bad
after { do_something }
it { does_something }

# bad
around { |test| test.run }
it { does_something }

# good
before { do_something }

it { does_something }

# good
after { do_something }

it { does_something }

# good
around { |test| test.run }

it { does_something }
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyLineAfterHook](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyLineAfterHook)

## RSpec/EmptyLineAfterSubject

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks if there is an empty line after subject block.

### Examples

```ruby
# bad
subject(:obj) { described_class }
let(:foo) { bar }

# good
subject(:obj) { described_class }

let(:foo) { bar }
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyLineAfterSubject](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/EmptyLineAfterSubject)

## RSpec/ExampleLength

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for long examples.

A long example is usually more difficult to understand. Consider
extracting out some behaviour, e.g. with a `let` block, or a helper
method.

### Examples

```ruby
# bad
it do
  service = described_class.new
  more_setup
  more_setup
  result = service.call
  expect(result).to be(true)
end

# good
it do
  service = described_class.new
  result = service.call
  expect(result).to be(true)
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
Max | `5` | Integer

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExampleLength](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExampleLength)

## RSpec/ExampleWithoutDescription

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for examples without a description.

RSpec allows for auto-generated example descriptions when there is no
description provided or the description is an empty one.

This cop removes empty descriptions.
It also defines whether auto-generated description is allowed, based
on the configured style.

This cop can be configured using the `EnforcedStyle` option

### Examples

#### `EnforcedStyle: always_allow`

```ruby
# bad
it('') { is_expected.to be_good }
it '' do
  result = service.call
  expect(result).to be(true)
end

# good
it { is_expected.to be_good }
it do
  result = service.call
  expect(result).to be(true)
end
```
#### `EnforcedStyle: single_line_only`

```ruby
# bad
it('') { is_expected.to be_good }
it do
  result = service.call
  expect(result).to be(true)
end

# good
it { is_expected.to be_good }
```
#### `EnforcedStyle: disallow`

```ruby
# bad
it { is_expected.to be_good }
it do
  result = service.call
  expect(result).to be(true)
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `always_allow` | `always_allow`, `single_line_only`, `disallow`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExampleWithoutDescription](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExampleWithoutDescription)

## RSpec/ExampleWording

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks for common mistakes in example descriptions.

This cop will correct docstrings that begin with 'should' and 'it'.

The autocorrect is experimental - use with care! It can be configured
with CustomTransform (e.g. have => has) and IgnoredWords (e.g. only).

### Examples

```ruby
# bad
it 'should find nothing' do
end

# good
it 'finds nothing' do
end
```
```ruby
# bad
it 'it does things' do
end

# good
it 'does things' do
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
CustomTransform | `{"be"=>"is", "BE"=>"IS", "have"=>"has", "HAVE"=>"HAS"}` | 
IgnoredWords | `[]` | Array

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExampleWording](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExampleWording)

## RSpec/ExpectActual

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for `expect(...)` calls containing literal values.

### Examples

```ruby
# bad
expect(5).to eq(price)
expect(/foo/).to eq(pattern)
expect("John").to eq(name)

# good
expect(price).to eq(5)
expect(pattern).to eq(/foo/)
expect(name).to eq("John")
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
Exclude | `spec/routing/**/*` | Array

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExpectActual](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExpectActual)

## RSpec/ExpectChange

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks for consistent style of change matcher.

Enforces either passing object and attribute as arguments to the matcher
or passing a block that reads the attribute value.

This cop can be configured using the `EnforcedStyle` option.

### Examples

#### `EnforcedStyle: block`

```ruby
# bad
expect { run }.to change(Foo, :bar)

# good
expect { run }.to change { Foo.bar }
```
#### `EnforcedStyle: method_call`

```ruby
# bad
expect { run }.to change { Foo.bar }
expect { run }.to change { foo.baz }

# good
expect { run }.to change(Foo, :bar)
expect { run }.to change(foo, :baz)
# also good when there are arguments or chained method calls
expect { run }.to change { Foo.bar(:count) }
expect { run }.to change { user.reload.name }
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `method_call` | `method_call`, `block`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExpectChange](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExpectChange)

## RSpec/ExpectInHook

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Do not use `expect` in hooks such as `before`.

### Examples

```ruby
# bad
before do
  expect(something).to eq 'foo'
end

# bad
after do
  expect_any_instance_of(Something).to receive(:foo)
end

# good
it do
  expect(something).to eq 'foo'
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExpectInHook](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExpectInHook)

## RSpec/ExpectOutput

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for opportunities to use `expect { ... }.to output`.

### Examples

```ruby
# bad
$stdout = StringIO.new
my_app.print_report
$stdout = STDOUT
expect($stdout.string).to eq('Hello World')

# good
expect { my_app.print_report }.to output('Hello World').to_stdout
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExpectOutput](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ExpectOutput)

## RSpec/FilePath

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks that spec file paths are consistent with the test subject.

Checks the path of the spec file and enforces that it reflects the
described class/module and its optionally called out method.

With the configuration option `IgnoreMethods` the called out method will
be ignored when determining the enforced path.

With the configuration option `CustomTransform` modules or classes can
be specified that should not as usual be transformed from CamelCase to
snake_case (e.g. 'RuboCop' => 'rubocop' ).

### Examples

```ruby
# bad
whatever_spec.rb         # describe MyClass

# bad
my_class_spec.rb         # describe MyClass, '#method'

# good
my_class_spec.rb         # describe MyClass

# good
my_class_method_spec.rb  # describe MyClass, '#method'

# good
my_class/method_spec.rb  # describe MyClass, '#method'
```
#### when configuration is `IgnoreMethods: true`

```ruby
# bad
whatever_spec.rb         # describe MyClass

# good
my_class_spec.rb         # describe MyClass

# good
my_class_spec.rb         # describe MyClass, '#method'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
CustomTransform | `{"RuboCop"=>"rubocop", "RSpec"=>"rspec"}` | 
IgnoreMethods | `false` | Boolean

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/FilePath](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/FilePath)

## RSpec/Focus

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks if examples are focused.

### Examples

```ruby
# bad
describe MyClass, focus: true do
end

describe MyClass, :focus do
end

fdescribe MyClass do
end

# good
describe MyClass do
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/Focus](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/Focus)

## RSpec/HookArgument

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks the arguments passed to `before`, `around`, and `after`.

This cop checks for consistent style when specifying RSpec
hooks which run for each example. There are three supported
styles: "implicit", "each", and "example." All styles have
the same behavior.

### Examples

#### when configuration is `EnforcedStyle: implicit`

```ruby
# bad
before(:each) do
  # ...
end

# bad
before(:example) do
  # ...
end

# good
before do
  # ...
end
```
#### when configuration is `EnforcedStyle: each`

```ruby
# bad
before(:example) do
  # ...
end

# good
before do
  # ...
end

# good
before(:each) do
  # ...
end
```
#### when configuration is `EnforcedStyle: example`

```ruby
# bad
before(:each) do
  # ...
end

# bad
before do
  # ...
end

# good
before(:example) do
  # ...
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `implicit` | `implicit`, `each`, `example`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/HookArgument](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/HookArgument)

## RSpec/HooksBeforeExamples

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks for before/around/after hooks that come after an example.

### Examples

```ruby
# Bad

it 'checks what foo does' do
  expect(foo).to be
end

before { prepare }
after { clean_up }

# Good
before { prepare }
after { clean_up }

it 'checks what foo does' do
  expect(foo).to be
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/HooksBeforeExamples](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/HooksBeforeExamples)

## RSpec/ImplicitBlockExpectation

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Check that implicit block expectation syntax is not used.

Prefer using explicit block expectations.

### Examples

```ruby
# bad
subject { -> { do_something } }
it { is_expected.to change(something).to(new_value) }

# good
it 'changes something to a new value' do
  expect { do_something }.to change(something).to(new_value)
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ImplicitBlockExpectation](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ImplicitBlockExpectation)

## RSpec/ImplicitExpect

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Check that a consistent implicit expectation style is used.

This cop can be configured using the `EnforcedStyle` option
and supports the `--auto-gen-config` flag.

### Examples

#### `EnforcedStyle: is_expected`

```ruby
# bad
it { should be_truthy }

# good
it { is_expected.to be_truthy }
```
#### `EnforcedStyle: should`

```ruby
# bad
it { is_expected.to be_truthy }

# good
it { should be_truthy }
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `is_expected` | `is_expected`, `should`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ImplicitExpect](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ImplicitExpect)

## RSpec/ImplicitSubject

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks for usage of implicit subject (`is_expected` / `should`).

This cop can be configured using the `EnforcedStyle` option

### Examples

#### `EnforcedStyle: single_line_only`

```ruby
# bad
it do
  is_expected.to be_truthy
end

# good
it { is_expected.to be_truthy }
it do
  expect(subject).to be_truthy
end
```
#### `EnforcedStyle: disallow`

```ruby
# bad
it { is_expected.to be_truthy }

# good
it { expect(subject).to be_truthy }
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `single_line_only` | `single_line_only`, `single_statement_only`, `disallow`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ImplicitSubject](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ImplicitSubject)

## RSpec/InstanceSpy

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks for `instance_double` used with `have_received`.

### Examples

```ruby
# bad
it do
  foo = instance_double(Foo).as_null_object
  expect(foo).to have_received(:bar)
end

# good
it do
  foo = instance_spy(Foo)
  expect(foo).to have_received(:bar)
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/InstanceSpy](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/InstanceSpy)

## RSpec/InstanceVariable

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for instance variable usage in specs.

This cop can be configured with the option `AssignmentOnly` which
will configure the cop to only register offenses on instance
variable usage if the instance variable is also assigned within
the spec

### Examples

```ruby
# bad
describe MyClass do
  before { @foo = [] }
  it { expect(@foo).to be_empty }
end

# good
describe MyClass do
  let(:foo) { [] }
  it { expect(foo).to be_empty }
end
```
#### with AssignmentOnly configuration

```ruby
# rubocop.yml
# RSpec/InstanceVariable:
#   AssignmentOnly: false

# bad
describe MyClass do
  before { @foo = [] }
  it { expect(@foo).to be_empty }
end

# allowed
describe MyClass do
  it { expect(@foo).to be_empty }
end

# good
describe MyClass do
  let(:foo) { [] }
  it { expect(foo).to be_empty }
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
AssignmentOnly | `false` | Boolean

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/InstanceVariable](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/InstanceVariable)

## RSpec/InvalidPredicateMatcher

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks invalid usage for predicate matcher.

Predicate matcher does not need a question.
This cop checks an unnecessary question in predicate matcher.

### Examples

```ruby
# bad
expect(foo).to be_something?

# good
expect(foo).to be_something
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/InvalidPredicateMatcher](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/InvalidPredicateMatcher)

## RSpec/ItBehavesLike

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks that only one `it_behaves_like` style is used.

### Examples

#### when configuration is `EnforcedStyle: it_behaves_like`

```ruby
# bad
it_should_behave_like 'a foo'

# good
it_behaves_like 'a foo'
```
#### when configuration is `EnforcedStyle: it_should_behave_like`

```ruby
# bad
it_behaves_like 'a foo'

# good
it_should_behave_like 'a foo'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `it_behaves_like` | `it_behaves_like`, `it_should_behave_like`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ItBehavesLike](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ItBehavesLike)

## RSpec/IteratedExpectation

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Check that `all` matcher is used instead of iterating over an array.

### Examples

```ruby
# bad
it 'validates users' do
  [user1, user2, user3].each { |user| expect(user).to be_valid }
end

# good
it 'validates users' do
  expect([user1, user2, user3]).to all(be_valid)
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/IteratedExpectation](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/IteratedExpectation)

## RSpec/LeadingSubject

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Enforce that subject is the first definition in the test.

### Examples

```ruby
# bad
  let(:params) { blah }
  subject { described_class.new(params) }

  before { do_something }
  subject { described_class.new(params) }

  it { expect_something }
  subject { described_class.new(params) }
  it { expect_something_else }

# good
  subject { described_class.new(params) }
  let(:params) { blah }

# good
  subject { described_class.new(params) }
  before { do_something }

# good
  subject { described_class.new(params) }
  it { expect_something }
  it { expect_something_else }
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/LeadingSubject](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/LeadingSubject)

## RSpec/LeakyConstantDeclaration

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks that no class, module, or constant is declared.

Constants, including classes and modules, when declared in a block
scope, are defined in global namespace, and leak between examples.

If several examples may define a `DummyClass`, instead of being a
blank slate class as it will be in the first example, subsequent
examples will be reopening it and modifying its behaviour in
unpredictable ways.
Even worse when a class that exists in the codebase is reopened.

Anonymous classes are fine, since they don't result in global
namespace name clashes.

### Examples

#### Constants leak between examples

```ruby
# bad
describe SomeClass do
  OtherClass = Struct.new
  CONSTANT_HERE = 'I leak into global namespace'
end

# good
describe SomeClass do
  before do
    stub_const('OtherClass', Struct.new)
    stub_const('CONSTANT_HERE', 'I only exist during this example')
  end
end
```
```ruby
# bad
describe SomeClass do
  class FooClass < described_class
    def double_that
      some_base_method * 2
    end
  end

  it { expect(FooClass.new.double_that).to eq(4) }
end

# good - anonymous class, no constant needs to be defined
describe SomeClass do
  let(:foo_class) do
    Class.new(described_class) do
      def double_that
        some_base_method * 2
      end
    end
  end

  it { expect(foo_class.new.double_that).to eq(4) }
end

# good - constant is stubbed
describe SomeClass do
  before do
    foo_class = Class.new(described_class) do
                  def do_something
                  end
                end
    stub_const('FooClass', foo_class)
  end

  it { expect(FooClass.new.double_that).to eq(4) }
end
```
```ruby
# bad
describe SomeClass do
  module SomeModule
    class SomeClass
      def do_something
      end
    end
  end
end

# good
describe SomeClass do
  before do
    foo_class = Class.new(described_class) do
                  def do_something
                  end
                end
    stub_const('SomeModule::SomeClass', foo_class)
  end
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/LeakyConstantDeclaration](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/LeakyConstantDeclaration)

## RSpec/LetBeforeExamples

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks for `let` definitions that come after an example.

### Examples

```ruby
# Bad
let(:foo) { bar }

it 'checks what foo does' do
  expect(foo).to be
end

let(:some) { other }

it 'checks what some does' do
  expect(some).to be
end

# Good
let(:foo) { bar }
let(:some) { other }

it 'checks what foo does' do
  expect(foo).to be
end

it 'checks what some does' do
  expect(some).to be
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/LetBeforeExamples](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/LetBeforeExamples)

## RSpec/LetSetup

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks unreferenced `let!` calls being used for test setup.

### Examples

```ruby
# Bad
let!(:my_widget) { create(:widget) }

it 'counts widgets' do
  expect(Widget.count).to eq(1)
end

# Good
it 'counts widgets' do
  create(:widget)
  expect(Widget.count).to eq(1)
end

# Good
before { create(:widget) }

it 'counts widgets' do
  expect(Widget.count).to eq(1)
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/LetSetup](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/LetSetup)

## RSpec/MessageChain

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Check that chains of messages are not being stubbed.

### Examples

```ruby
# bad
allow(foo).to receive_message_chain(:bar, :baz).and_return(42)

# better
thing = Thing.new(baz: 42)
allow(foo).to receive(bar: thing)
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MessageChain](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MessageChain)

## RSpec/MessageExpectation

Enabled by default | Supports autocorrection
--- | ---
Disabled | No

Checks for consistent message expectation style.

This cop can be configured in your configuration using the
`EnforcedStyle` option and supports `--auto-gen-config`.

### Examples

#### `EnforcedStyle: allow`

```ruby
# bad
expect(foo).to receive(:bar)

# good
allow(foo).to receive(:bar)
```
#### `EnforcedStyle: expect`

```ruby
# bad
allow(foo).to receive(:bar)

# good
expect(foo).to receive(:bar)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `allow` | `allow`, `expect`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MessageExpectation](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MessageExpectation)

## RSpec/MessageSpies

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks that message expectations are set using spies.

This cop can be configured in your configuration using the
`EnforcedStyle` option and supports `--auto-gen-config`.

### Examples

#### `EnforcedStyle: have_received`

```ruby
# bad
expect(foo).to receive(:bar)

# good
expect(foo).to have_received(:bar)
```
#### `EnforcedStyle: receive`

```ruby
# bad
expect(foo).to have_received(:bar)

# good
expect(foo).to receive(:bar)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `have_received` | `have_received`, `receive`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MessageSpies](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MessageSpies)

## RSpec/MissingExampleGroupArgument

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks that the first argument to an example group is not empty.

### Examples

```ruby
# bad
describe do
end

RSpec.describe do
end

# good
describe TestedClass do
end

describe "A feature example" do
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MissingExampleGroupArgument](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MissingExampleGroupArgument)

## RSpec/MultipleDescribes

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for multiple top level describes.

Multiple descriptions for the same class or module should either
be nested or separated into different test files.

### Examples

```ruby
# bad
describe MyClass, '.do_something' do
end
describe MyClass, '.do_something_else' do
end

# good
describe MyClass do
  describe '.do_something' do
  end
  describe '.do_something_else' do
  end
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MultipleDescribes](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MultipleDescribes)

## RSpec/MultipleExpectations

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks if examples contain too many `expect` calls.

This cop is configurable using the `Max` option
and works with `--auto-gen-config`.

### Examples

```ruby
# bad
describe UserCreator do
  it 'builds a user' do
    expect(user.name).to eq("John")
    expect(user.age).to eq(22)
  end
end

# good
describe UserCreator do
  it 'sets the users name' do
    expect(user.name).to eq("John")
  end

  it 'sets the users age' do
    expect(user.age).to eq(22)
  end
end
```
#### configuration

```ruby
# .rubocop.yml
# RSpec/MultipleExpectations:
#   Max: 2

# not flagged by rubocop
describe UserCreator do
  it 'builds a user' do
    expect(user.name).to eq("John")
    expect(user.age).to eq(22)
  end
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
Max | `1` | Integer
AggregateFailuresByDefault | `false` | Boolean

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MultipleExpectations](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MultipleExpectations)

## RSpec/MultipleSubjects

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks if an example group defines `subject` multiple times.

The autocorrect behavior for this cop depends on the type of
duplication:

  - If multiple named subjects are defined then this probably indicates
    that the overwritten subjects (all subjects except the last
    definition) are effectively being used to define helpers. In this
    case they are replaced with `let`.

  - If multiple unnamed subjects are defined though then this can *only*
    be dead code and we remove the overwritten subject definitions.

  - If subjects are defined with `subject!` then we don't autocorrect.
    This is enough of an edge case that people can just move this to
    a `before` hook on their own

### Examples

```ruby
# bad
describe Foo do
  subject(:user) { User.new }
  subject(:post) { Post.new }
end

# good
describe Foo do
  let(:user) { User.new }
  subject(:post) { Post.new }
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MultipleSubjects](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/MultipleSubjects)

## RSpec/NamedSubject

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for explicitly referenced test subjects.

RSpec lets you declare an "implicit subject" using `subject { ... }`
which allows for tests like `it { should be_valid }`. If you need to
reference your test subject you should explicitly name it using
`subject(:your_subject_name) { ... }`. Your test subjects should be
the most important object in your tests so they deserve a descriptive
name.

This cop can be configured in your configuration using the
`IgnoreSharedExamples` which will not report offenses for implicit
subjects in shared example groups.

### Examples

```ruby
# bad
RSpec.describe User do
  subject { described_class.new }

  it 'is valid' do
    expect(subject.valid?).to be(true)
  end
end

# good
RSpec.describe Foo do
  subject(:user) { described_class.new }

  it 'is valid' do
    expect(user.valid?).to be(true)
  end
end

# also good
RSpec.describe Foo do
  subject(:user) { described_class.new }

  it { should be_valid }
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
IgnoreSharedExamples | `true` | Boolean

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/NamedSubject](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/NamedSubject)

## RSpec/NestedGroups

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for nested example groups.

This cop is configurable using the `Max` option
and supports `--auto-gen-config

### Examples

```ruby
# bad
context 'when using some feature' do
  let(:some)    { :various }
  let(:feature) { :setup   }

  context 'when user is signed in' do  # flagged by rubocop
    let(:user) do
      UserCreate.call(user_attributes)
    end

    let(:user_attributes) do
      {
        name: 'John',
        age:  22,
        role: role
      }
    end

    context 'when user is an admin' do # flagged by rubocop
      let(:role) { 'admin' }

      it 'blah blah'
      it 'yada yada'
    end
  end
end

# better
context 'using some feature as an admin' do
  let(:some)    { :various }
  let(:feature) { :setup   }

  let(:user) do
    UserCreate.call(
      name: 'John',
      age:  22,
      role: 'admin'
    )
  end

  it 'blah blah'
  it 'yada yada'
end
```
#### configuration

```ruby
# .rubocop.yml
# RSpec/NestedGroups:
#   Max: 2

context 'when using some feature' do
  let(:some)    { :various }
  let(:feature) { :setup   }

  context 'when user is signed in' do
    let(:user) do
      UserCreate.call(user_attributes)
    end

    let(:user_attributes) do
      {
        name: 'John',
        age:  22,
        role: role
      }
    end

    context 'when user is an admin' do # flagged by rubocop
      let(:role) { 'admin' }

      it 'blah blah'
      it 'yada yada'
    end
  end
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
Max | `3` | Integer

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/NestedGroups](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/NestedGroups)

## RSpec/NotToNot

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks for consistent method usage for negating expectations.

### Examples

```ruby
# bad
it '...' do
  expect(false).to_not be_true
end

# good
it '...' do
  expect(false).not_to be_true
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `not_to` | `not_to`, `to_not`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/NotToNot](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/NotToNot)

## RSpec/OverwritingSetup

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks if there is a let/subject that overwrites an existing one.

### Examples

```ruby
# bad
let(:foo) { bar }
let(:foo) { baz }

subject(:foo) { bar }
let(:foo) { baz }

let(:foo) { bar }
let!(:foo) { baz }

# good
subject(:test) { something }
let(:foo) { bar }
let(:baz) { baz }
let!(:other) { other }
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/OverwritingSetup](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/OverwritingSetup)

## RSpec/Pending

Enabled by default | Supports autocorrection
--- | ---
Disabled | No

Checks for any pending or skipped examples.

### Examples

```ruby
# bad
describe MyClass do
  it "should be true"
end

describe MyClass do
  it "should be true", skip: true do
    expect(1).to eq(2)
  end
end

describe MyClass do
  it "should be true" do
    pending
  end
end

describe MyClass do
  xit "should be true" do
  end
end

# good
describe MyClass do
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/Pending](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/Pending)

## RSpec/PredicateMatcher

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Prefer using predicate matcher over using predicate method directly.

RSpec defines magic matchers for predicate methods.
This cop recommends to use the predicate matcher instead of using
predicate method directly.

### Examples

#### Strict: true, EnforcedStyle: inflected (default)

```ruby
# bad
expect(foo.something?).to be_truthy

# good
expect(foo).to be_something

# also good - It checks "true" strictly.
expect(foo).to be(true)
```
#### Strict: false, EnforcedStyle: inflected

```ruby
# bad
expect(foo.something?).to be_truthy
expect(foo).to be(true)

# good
expect(foo).to be_something
```
#### Strict: true, EnforcedStyle: explicit

```ruby
# bad
expect(foo).to be_something

# good - the above code is rewritten to it by this cop
expect(foo.something?).to be(true)
```
#### Strict: false, EnforcedStyle: explicit

```ruby
# bad
expect(foo).to be_something

# good - the above code is rewritten to it by this cop
expect(foo.something?).to be_truthy
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
Strict | `true` | Boolean
EnforcedStyle | `inflected` | `inflected`, `explicit`
AllowedExplicitMatchers | `[]` | Array

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/PredicateMatcher](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/PredicateMatcher)

## RSpec/ReceiveCounts

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Check for `once` and `twice` receive counts matchers usage.

### Examples

```ruby
# bad
expect(foo).to receive(:bar).exactly(1).times
expect(foo).to receive(:bar).exactly(2).times
expect(foo).to receive(:bar).at_least(1).times
expect(foo).to receive(:bar).at_least(2).times
expect(foo).to receive(:bar).at_most(1).times
expect(foo).to receive(:bar).at_most(2).times

# good
expect(foo).to receive(:bar).once
expect(foo).to receive(:bar).twice
expect(foo).to receive(:bar).at_least(:once)
expect(foo).to receive(:bar).at_least(:twice)
expect(foo).to receive(:bar).at_most(:once)
expect(foo).to receive(:bar).at_most(:twice).times
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ReceiveCounts](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ReceiveCounts)

## RSpec/ReceiveNever

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Prefer `not_to receive(...)` over `receive(...).never`.

### Examples

```ruby
# bad
expect(foo).to receive(:bar).never

# good
expect(foo).not_to receive(:bar)
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ReceiveNever](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ReceiveNever)

## RSpec/RepeatedDescription

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Check for repeated description strings in example groups.

### Examples

```ruby
# bad
RSpec.describe User do
  it 'is valid' do
    # ...
  end

  it 'is valid' do
    # ...
  end
end

# good
RSpec.describe User do
  it 'is valid when first and last name are present' do
    # ...
  end

  it 'is valid when last name only is present' do
    # ...
  end
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/RepeatedDescription](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/RepeatedDescription)

## RSpec/RepeatedExample

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Check for repeated examples within example groups.

### Examples

```ruby
it 'is valid' do
  expect(user).to be_valid
end

it 'validates the user' do
  expect(user).to be_valid
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/RepeatedExample](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/RepeatedExample)

## RSpec/ReturnFromStub

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks for consistent style of stub's return setting.

Enforces either `and_return` or block-style return in the cases
where the returned value is constant. Ignores dynamic returned values
are the result would be different

This cop can be configured using the `EnforcedStyle` option

### Examples

#### `EnforcedStyle: block`

```ruby
# bad
allow(Foo).to receive(:bar).and_return("baz")
expect(Foo).to receive(:bar).and_return("baz")

# good
allow(Foo).to receive(:bar) { "baz" }
expect(Foo).to receive(:bar) { "baz" }
# also good as the returned value is dynamic
allow(Foo).to receive(:bar).and_return(bar.baz)
```
#### `EnforcedStyle: and_return`

```ruby
# bad
allow(Foo).to receive(:bar) { "baz" }
expect(Foo).to receive(:bar) { "baz" }

# good
allow(Foo).to receive(:bar).and_return("baz")
expect(Foo).to receive(:bar).and_return("baz")
# also good as the returned value is dynamic
allow(Foo).to receive(:bar) { bar.baz }
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `and_return` | `and_return`, `block`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ReturnFromStub](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ReturnFromStub)

## RSpec/ScatteredLet

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for let scattered across the example group.

Group lets together

### Examples

```ruby
# bad
describe Foo do
  let(:foo) { 1 }
  subject { Foo }
  let(:bar) { 2 }
  before { prepare }
  let!(:baz) { 3 }
end

# good
describe Foo do
  subject { Foo }
  before { prepare }
  let(:foo) { 1 }
  let(:bar) { 2 }
  let!(:baz) { 3 }
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ScatteredLet](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ScatteredLet)

## RSpec/ScatteredSetup

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for setup scattered across multiple hooks in an example group.

Unify `before`, `after`, and `around` hooks when possible.

### Examples

```ruby
# bad
describe Foo do
  before { setup1 }
  before { setup2 }
end

# good
describe Foo do
  before do
    setup1
    setup2
  end
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ScatteredSetup](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/ScatteredSetup)

## RSpec/SharedContext

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks for proper shared_context and shared_examples usage.

If there are no examples defined, use shared_context.
If there is no setup defined, use shared_examples.

### Examples

```ruby
# bad
RSpec.shared_context 'only examples here' do
  it 'does x' do
  end

  it 'does y' do
  end
end

# good
RSpec.shared_examples 'only examples here' do
  it 'does x' do
  end

  it 'does y' do
  end
end
```
```ruby
# bad
RSpec.shared_examples 'only setup here' do
  subject(:foo) { :bar }

  let(:baz) { :bazz }

  before do
    something
  end
end

# good
RSpec.shared_context 'only setup here' do
  subject(:foo) { :bar }

  let(:baz) { :bazz }

  before do
    something
  end
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/SharedContext](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/SharedContext)

## RSpec/SharedExamples

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Enforces use of string to titleize shared examples.

### Examples

```ruby
# bad
it_behaves_like :foo_bar_baz
it_should_behave_like :foo_bar_baz
shared_examples :foo_bar_baz
shared_examples_for :foo_bar_baz
include_examples :foo_bar_baz

# good
it_behaves_like 'foo bar baz'
it_should_behave_like 'foo bar baz'
shared_examples 'foo bar baz'
shared_examples_for 'foo bar baz'
include_examples 'foo bar baz'
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/SharedExamples](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/SharedExamples)

## RSpec/SingleArgumentMessageChain

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks that chains of messages contain more than one element.

### Examples

```ruby
# bad
allow(foo).to receive_message_chain(:bar).and_return(42)

# good
allow(foo).to receive(:bar).and_return(42)

# also good
allow(foo).to receive(:bar, :baz)
allow(foo).to receive("bar.baz")
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/SingleArgumentMessageChain](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/SingleArgumentMessageChain)

## RSpec/SubjectStub

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for stubbed test subjects.

### Examples

```ruby
# bad
describe Foo do
  subject(:bar) { baz }

  before do
    allow(bar).to receive(:qux?).and_return(true)
  end
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/SubjectStub](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/SubjectStub)

## RSpec/UnspecifiedException

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for a specified error in checking raised errors.

Enforces one of an Exception type, a string, or a regular
expression to match against the exception message as a parameter
to `raise_error`

### Examples

```ruby
# bad
expect {
  raise StandardError.new('error')
}.to raise_error

# good
expect {
  raise StandardError.new('error')
}.to raise_error(StandardError)

expect {
  raise StandardError.new('error')
}.to raise_error('error')

expect {
  raise StandardError.new('error')
}.to raise_error(/err/)

expect { do_something }.not_to raise_error
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/UnspecifiedException](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/UnspecifiedException)

## RSpec/VerifiedDoubles

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Prefer using verifying doubles over normal doubles.

### Examples

```ruby
# bad
let(:foo) do
  double(method_name: 'returned value')
end

# bad
let(:foo) do
  double("ClassName", method_name: 'returned value')
end

# good
let(:foo) do
  instance_double("ClassName", method_name: 'returned value')
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
IgnoreNameless | `true` | Boolean
IgnoreSymbolicNames | `false` | Boolean

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/VerifiedDoubles](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/VerifiedDoubles)

## RSpec/VoidExpect

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

This cop checks void `expect()`.

### Examples

```ruby
# bad
expect(something)

# good
expect(something).to be(1)
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/VoidExpect](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/VoidExpect)

## RSpec/Yield

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

This cop checks for calling a block within a stub.

### Examples

```ruby
# bad
allow(foo).to receive(:bar) { |&block| block.call(1) }

# good
expect(foo).to be(:bar).and_yield(1)
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/Yield](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/Yield)
