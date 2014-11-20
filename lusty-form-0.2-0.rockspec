package = "lusty-form"
version = "0.2-0"
source = {
  url = "https://github.com/Olivine-Labs/lusty-form/archive/v0.2.tar.gz",
  dir = "lusty-form-0.2"
}
description = {
  summary = "form input for lusty.",
  detailed = [[
    Input extensions for lusty
  ]],
  homepage = "http://olivinelabs.com/lusty/",
  license = "MIT <http://opensource.org/licenses/MIT>"
}
dependencies = {
  "lua >= 5.1",
  "lusty >= 0.1-0",
  "busted >= 1.7-1"
}
build = {
  type = "builtin",
  modules = {
    ["lusty-form.input.form"]  = "lusty-form/input/form.lua",
  }
}
