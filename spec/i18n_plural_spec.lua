local plural = require 'i18n.plural'

describe('i18n.plural', function()

  it("exists", function()
    assert_equal('table', type(plural))
  end)

  describe('plural.get', function()

    it('throws an error with the wrong parameters', function()
      assert_error(function() plural.get() end)
      assert_error(function() plural.get(1,1) end)
      assert_error(function() plural.get('en', 'en') end)
    end)

    describe("When dealing with locales", function()

      local function test_get(title, locale, results)
        describe('When pluralizing ' .. title, function()
          for n, result in pairs(results) do
            it(('translates %s into %q'):format(n, result), function()
              assert_equal(plural.get(locale, n), result)
            end)
          end
        end)
      end

      test_get('Afrikaans (f1)', 'af', {
        [1]   = 'one',
        [0]   = 'other',
        [0.5] = 'other',
        [2]   = 'other'
      })

      test_get('Akan (f2)', 'ak', {
        [1]   = 'one',
        [0]   = 'one',
        [0.5] = 'other',
        [2]   = 'other'
      })

      test_get('Arabic(f3)', 'ar', {
        [0]   = 'zero',
        [1]   = 'one',
        [2]   = 'two',
        [3]   = 'few',
        [903] = 'few',
        [111] = 'many',
        [222] = 'many',
        [0.5] = 'other'
      })

      test_get('Azerbaijani(f4)', 'az', {
        [0]   = 'other',
        [1]   = 'other',
        [0.5] = 'other'
      })

      test_get('Belarusian(f5)', 'be', {
        [1]   = 'one',
        [31]  = 'one',
        [3]   = 'few',
        [33]  = 'few',
        [5]   = 'many',
        [19]  = 'many',
        [35]  = 'many',
        [0.5] = 'other'
      })

      test_get('Breton(f5)', 'br', {
        [1]   = 'one',
        [21]  = 'one',
        [2]   = 'two',
        [22]  = 'two',
        [3]   = 'few',
        [4]   = 'few',
        [23]  = 'few',
        [29]  = 'few',
        [10000000] = 'many',
        [0]   = 'other',
        [0.5] = 'other'
      })

      test_get('Czech(f7)', 'cz', {
        [1]   = 'one',
        [2]   = 'few',
        [4]   = 'few',
        [5]   = 'other',
        [0.5] = 'other'
      })

      test_get('Welsh(f8)', 'cy', {
        [0]   = 'zero',
        [1]   = 'one',
        [2]   = 'two',
        [3]   = 'few',
        [6]   = 'many',
        [0.5] = 'other'
      })

      test_get('Fulah(f9)', 'ff', {
        [0]   = 'one',
        [0.5] = 'one',
        [1]   = 'one',
        [1.5] = 'one',
        [2]   = 'other'
      })

      test_get('Irish(f10)', 'ga', {
        [1]   = 'one',
        [2]   = 'two',
        [3]   = 'few',
        [6]   = 'few',
        [0]   = 'other',
        [-1]  = 'other',
        [2.5] = 'other',
        [100] = 'other'
      })

      test_get('Scottish Gaelic(f11)', 'gd', {
        [1]   = 'one',
        [11]  = 'one',
        [2]   = 'two',
        [12]  = 'two',
        [3]   = 'few',
        [10]  = 'few',
        [13]  = 'few',
        [19]  = 'few',
        [0]   = 'other',
        [-1]  = 'other',
        [2.5] = 'other',
        [100] = 'other'
      })

      test_get('Manx(12)', 'gv', {
        [0]   = 'one',
        [2]   = 'one',
        [11]  = 'one',
        [12]  = 'one',
        [20]  = 'one',
        [22]  = 'one',
        [3]   = 'other',
        [13]  = 'other',
        [-2]  = 'other',
        [1.5] = 'other'
      })

      test_get('Inuktitut(f13)', 'iu', {
        [1]   = 'one',
        [2]   = 'two',
        [0]   = 'other',
        [-1]  = 'other',
        [0.5] = 'other'
      })

      test_get('Colognian(f14)', 'ksh', {
        [0]   = 'zero',
        [1]   = 'one',
        [2]   = 'other',
        [-1]  = 'other',
        [0.5] = 'other'
      })

      test_get('Langi(f15)', 'lag', {
        [0]   = 'zero',
        [0.5] = 'one',
        [1]   = 'one',
        [1.5] = 'one',
        [2]   = 'other',
        [-1]  = 'other'
      })

      test_get('Lithuanian(f16)', 'lt', {
        [1]   = 'one',
        [21]  = 'one',
        [2]   = 'few',
        [22]  = 'few',
        [0]   = 'other'
      })

      test_get('Latvian(f17)', 'lv', {
        [0]   = 'zero',
        [1]   = 'one',
        [21]  = 'one',
        [2]   = 'other',
        [0.5] = 'other'
      })

      test_get('Macedonian(f18)', 'mk', {
        [1]   = 'one',
        [21]  = 'one',
        [0]   = 'other',
        [2]   = 'other',
        [0.5] = 'other'
      })

      test_get('Moldavian(f19)', 'mo', {
        [1]   = 'one',
        [2]   = 'few',
        [0]   = 'few',
        [19]  = 'few',
        [101] = 'few',
        [119] = 'few',
        [20]  = 'other',
        [2.7] = 'other'
      })

      test_get('Maltese(f20)', 'mt', {
        [1]   = 'one',
        [2]   = 'few',
        [0]   = 'few',
        [19]  = 'many',
        [11]  = 'many',
        [119] = 'many',
        [20]  = 'other',
        [2.7] = 'other'
      })

    end)

  end)
end)
