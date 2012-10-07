i18n.lua
========

A very minimal i18n lib for Lua

Description
===========

``` lua
i18n = require 'i18n'

-- loading stuff
i18n.set('en', 'welcome', 'Welcome to this program')
i18n.set('en.welcome', 'Welcome to this program') -- same as above
i18n.load({
  en = {
    good_bye = "Good-bye!",
    messages = "You've got %d unread message(s)"
  }
})

-- setting the translation context
i18n.setContext('en')

-- getting translations
i18n('welcome') -- Welcome to this program
i18n('messages', 2) -- You've got 2 unread message(s)"
i18n('good_bye') -- Good-bye!
```

Specs
=====
This project uses [telescope](https://github.com/norman/telescope) for its specs. If you want to run the specs, you will have to install telescope first. Then just execute the following from the root inspect folder:

    tsc -f spec/*
