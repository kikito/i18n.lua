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
      i18n.set('en.message', 'Hello %s, your score is %d')
      assert_equal('Hello Vegeta, your score is 9001', i18n('en.message', 'Vegeta', 9001))
    end)

    it('checks that the first two parameters are non-empty strings', function()
      assert_error(function() i18n.set("","") end)
      assert_error(function() i18n.set("",1) end)
      assert_error(function() i18n.set(1,1) end)
      assert_error(function() i18n.set() end)
    end)

  end)


  describe('load', function()

  end)

end)
