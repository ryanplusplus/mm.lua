package = 'mm.lua'
version = 'scm-1'
source = {
   url = 'git+https://github.com/ryanplusplus/mm.lua.git'
}
description = {
   homepage = 'https://github.com/ryanplusplus/mm.lua',
   license = 'MIT'
}
dependencies = {
  'busted == 2.0.rc12-1',
  'mach == 4.7-0'
}
build = {
  type = 'builtin',
  modules = {}
}
