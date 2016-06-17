promisify = require 'es6-promisify'
fs = require 'fs'

aMethods = [
  'access'
  'readFile'
  'writeFile'
  'close'
  'open'
  'read'
  'write'
  'rename'
  'rmdir'
  'mkdir'
  'readdir'
  'stat'
  'appendFile'
  'realpath'
]

# Wrap
aMethods.forEach (sMethod) ->
  unless fs[sMethod]
    return
  exports[sMethod] = promisify fs[sMethod]
