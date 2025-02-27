# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::FactoryBot::FactoryClassName do
  subject(:cop) { described_class.new }

  context 'when passing block' do
    it 'flags passing a class' do
      expect_offense(<<~RUBY)
        factory :foo, class: Foo do
                             ^^^ Pass 'Foo' instead of Foo.
        end
      RUBY

      expect_correction(<<~RUBY)
        factory :foo, class: 'Foo' do
        end
      RUBY
    end

    it 'flags passing a class from global namespace' do
      expect_offense(<<~RUBY)
        factory :foo, class: ::Foo do
                             ^^^^^ Pass 'Foo' instead of Foo.
        end
      RUBY

      expect_correction(<<~RUBY)
        factory :foo, class: '::Foo' do
        end
      RUBY
    end

    it 'flags passing a subclass' do
      expect_offense(<<~RUBY)
        factory :foo, class: Foo::Bar do
                             ^^^^^^^^ Pass 'Foo::Bar' instead of Foo::Bar.
        end
      RUBY

      expect_correction(<<~RUBY)
        factory :foo, class: 'Foo::Bar' do
        end
      RUBY
    end

    it 'ignores passing class name' do
      expect_no_offenses(<<~RUBY)
        factory :foo, class: 'Foo' do
        end
      RUBY
    end
  end

  context 'when not passing block' do
    it 'flags passing a class' do
      expect_offense(<<~RUBY)
        factory :foo, class: Foo
                             ^^^ Pass 'Foo' instead of Foo.
      RUBY

      expect_correction(<<~RUBY)
        factory :foo, class: 'Foo'
      RUBY
    end

    it 'ignores passing class name' do
      expect_no_offenses(<<~RUBY)
        factory :foo, class: 'Foo'
      RUBY
    end
  end
end
