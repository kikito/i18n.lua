package = "i18n"
version = "0.5-1"
source = {
  url = "https://github.com/downloads/kikito/i18n.lua/i18n-0.5.tar.gz"
}
description = {
  summary = "Small but powerful internationalization library for Lua",
  detailed = [[
    i18n can handle hierarchies of tags, accepts entries in several ways (one by one, in a table or in a file) and implements basic pluralization..
  ]],
  homepage = "https://github.com/kikito/i18n.lua",
  license = "MIT <http://opensource.org/licenses/MIT>"
}
dependencies = {
  "lua >= 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["i18n"] = "i18n.lua"
  }
}
