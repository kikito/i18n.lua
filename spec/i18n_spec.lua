local i18n = require 'i18n'

describe('i18n', function()

  before(i18n.reset)

  describe('get/set', function()
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

  describe('set/getContext', function()
    it("is split and parsed properly", function()
      i18n.setContext('en', 'foo')
      assert_equal('en.foo', i18n.getContext())
      i18n.setContext('en.foo.bar')
      assert_equal('en.foo.bar', i18n.getContext())
      i18n.setContext()
      assert_equal("", i18n.getContext())
    end)

    it("modifies set", function()
      i18n.setContext('en')
      i18n.set('foo','bar')
      i18n.setContext()
      assert_equal('bar', i18n('en.foo'))
    end)

    it("modifies get", function()
      i18n.set('en','foo','bar')
      i18n.setContext('en')
      assert_equal('bar', i18n('foo'))
    end)
  end)

  describe('load', function()
  end)



end)
