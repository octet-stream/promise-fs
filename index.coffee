pify = require 'pify'
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
  'lstat'
  'fstat'
  'appendFile'
  'realpath'
  'link'
  'unlink'
  'readlink'
  'chmod'
  'fchmod'
  'chown'
  'fchown'
  'lchown'
  'fsync'
  'utimes'
  'futimes'
  'ftruncate'
]

# Wrap fs methods
aMethods.forEach (sMethod) ->
  unless fs[sMethod]
    return

  exports[sMethod] = pify fs[sMethod]
