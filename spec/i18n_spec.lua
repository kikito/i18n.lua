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

    it('interpolates variables', function()
      i18n.set('en.message', 'Hello %s, your score is %d')
      assert_equal('Hello Vegeta, your score is 9001', i18n('en.message', 'Vegeta', 9001))
    end)

  end)


  describe('load', function()

  end)

end)
