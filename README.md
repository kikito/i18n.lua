i18n.lua
========

A very minimal i18n lib for Lua

Description
===========

``` lua
i18n = require 'i18n'

-- loading stuff
i18n.set('en.welcome', 'Welcome to this program')
i18n.load({
  en = {
    good_bye = "Good-bye!",
    age_msg = "Your age is %{age}."
    phone_msg = {
      one = "You have one new message.",
      other = "You have %{count} new messages."
    }
  }
})
i18n.loadFile('path/to/your/files/en.lua') -- maybe load some more stuff from that file

-- setting the translation context
i18n.setLocale('en')

-- getting translations
i18n.translate('welcome') -- Welcome to this program
i18n('welcome') -- Welcome to this program
i18n('age_msg', {age = 18}) -- Your age is 18.
i18n('phone_msg', {count = 1}) -- You have one new message.
i18n('phone_msg', {count = 2}) -- You have 2 new messages.
i18n('good_bye') -- Good-bye!
```

Specs
=====
This project uses [telescope](https://github.com/norman/telescope) for its specs. If you want to run the specs, you will have to install telescope first. Then just execute the following from the root inspect folder:

    tsc -f spec/*
