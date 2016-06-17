var aMethods, fs, promisify;

promisify = require('es6-promisify');

fs = require('fs');

aMethods = ['access', 'readFile', 'writeFile', 'close', 'open', 'read', 'write', 'rename', 'rmdir', 'mkdir', 'readdir', 'stat', 'appendFile', 'realpath'];

aMethods.forEach(function(sMethod) {
  if (!fs[sMethod]) {
    return;
  }
  return exports[sMethod] = promisify(fs[sMethod]);
});
