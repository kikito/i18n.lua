require 'spec.fixPackagePath'

local i18n = require 'i18n'

describe('i18n', function()

  before(i18n.reset)

  describe('translate/set', function()
    it('sets a value in the internal store', function()
      i18n.set('foo','var')
      assert_equal('var', i18n('foo'))
    end)

    it('sets a hierarchy of values', function()
      i18n.set('en', 'message', 'hello!')
      assert_equal('hello!', i18n('en', 'message'))
    end)

    it('splits keys via their dots', function()
      i18n.set('en.message', 'hello!')
      assert_equal('hello!', i18n('en', 'message'))
      assert_equal('hello!', i18n('en.message'))
    end)

    it('only splits first param', function()
      i18n.set('en.foo', 'bar.baz', "A message in en.foo['bar.baz']")
      assert_equal("A message in en.foo['bar.baz']", i18n('en','foo','bar.baz'))
    end)

    it('interpolates variables', function()
      i18n.set('en.message', 'Hello %{name}, your score is %{score}')
      assert_equal('Hello Vegeta, your score is 9001', i18n('en.message', {name = 'Vegeta', score = 9001}))
    end)

    it('checks that the first two parameters are non-empty strings', function()
      assert_error(function() i18n.set("","") end)
      assert_error(function() i18n.set("",1) end)
      assert_error(function() i18n.set(1,1) end)
      assert_error(function() i18n.set() end)
    end)

    describe('when there is a count-type translation', function()
      before(function()
        i18n.set('a.message', {
          one   = "Only one message.",
          other = "%{count} messages."
        })
      end)

      it('interpolates one correctly', function()
        assert_equal("Only one message.", i18n('a.message', {count = 1}))
      end)

      it('interpolates many correctly', function()
        assert_equal("2 messages.", i18n('a.message', {count = 2}))
      end)

      it('defaults to 1', function()
        assert_equal("Only one message.", i18n('a.message'))
      end)

    end)
  end)

  describe('load', function()
    it("loads a bunch of stuff", function()
      i18n.load({
        en = {
          hello  = 'Hello!',
          inter  = 'Your weight: %{weight}',
          plural = {
            one = "One thing",
            other = "%{count} things"
          }
        },
        es = {
          hello  = '¡Hola!',
          inter  = 'Su peso: %{weight}',
          plural = {
            one = "Una cosa",
            other = "%{count} cosas"
          }
        }
      })

      assert_equal('Hello!', i18n('en.hello'))
      assert_equal('Your weight: 5', i18n('en.inter', {weight = 5}))
      assert_equal('One thing', i18n('en.plural', {count = 1}))
      assert_equal('2 things', i18n('en.plural', {count = 2}))
      assert_equal('¡Hola!', i18n('es.hello'))
      assert_equal('Su peso: 5', i18n('es.inter', {weight = 5}))
      assert_equal('Una cosa', i18n('es.plural', {count = 1}))
      assert_equal('2 cosas', i18n('es.plural', {count = 2}))
    end)
  end)

  describe('loadFile', function()
    it("Loads a bunch of stuff", function()
      i18n.loadFile('spec/en.lua')
      assert_equal('Hello!', i18n('en.hello'))
      local balance = i18n('en.balance', {value = 0})
      assert_equal('Your account balance is 0.', balance)
    end)
  end)

  describe('set/getLocale', function()
    it("is split and parsed properly", function()
      i18n.setLocale('en', 'foo')
      assert_equal('en.foo', i18n.getLocale())
      i18n.setLocale('en.foo.bar')
      assert_equal('en.foo.bar', i18n.getLocale())
      i18n.setLocale()
      assert_equal("", i18n.getLocale())
    end)

    it("modifies translate", function()
      i18n.set('en','foo','bar')
      i18n.setLocale('en')
      assert_equal('bar', i18n('foo'))
    end)

    it("does NOT modify set", function()
      i18n.setLocale('en')
      i18n.set('en.foo','bar')
      assert_equal('bar', i18n('foo'))
    end)

    it("does NOT modify load", function()
      i18n.setLocale('en')
      i18n.load({en = {foo = 'Foo'}})
      assert_equal('Foo', i18n('foo'))
    end)

    it("does NOT modify loadFile", function()
      i18n.setLocale('en')
      i18n.loadFile('spec/en.lua')
      assert_equal('Hello!', i18n('hello'))
    end)
  end)

end)
