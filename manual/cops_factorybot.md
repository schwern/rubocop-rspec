# FactoryBot

## FactoryBot/AttributeDefinedStatically

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Always declare attribute values as blocks.

### Examples

```ruby
# bad
kind [:active, :rejected].sample

# good
kind { [:active, :rejected].sample }

# bad
closed_at 1.day.from_now

# good
closed_at { 1.day.from_now }

# bad
count 1

# good
count { 1 }
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/FactoryBot/AttributeDefinedStatically](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/FactoryBot/AttributeDefinedStatically)

## FactoryBot/CreateList

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks for create_list usage.

This cop can be configured using the `EnforcedStyle` option

### Examples

#### `EnforcedStyle: create_list`

```ruby
# bad
3.times { create :user }

# good
create_list :user, 3

# good
3.times { |n| create :user, created_at: n.months.ago }
```
#### `EnforcedStyle: n_times`

```ruby
# bad
create_list :user, 3

# good
3.times { create :user }
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `create_list` | `create_list`, `n_times`

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/FactoryBot/CreateList](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/FactoryBot/CreateList)

## FactoryBot/FactoryClassName

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use string value when setting the class attribute explicitly.

### Examples

```ruby
# bad
factory :foo, class: Foo do
end

# good
factory :foo, class: 'Foo' do
end
```

### References

* [https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/FactoryBot/FactoryClassName](https://www.rubydoc.info/gems/rubocop-rspec/RuboCop/Cop/RSpec/FactoryBot/FactoryClassName)
