var fs, path;

fs = require('./index');

path = require('path');

fs.readFilePromise(path.join(fs.realpathSync(__dirname), '../test/file.json')).then(function(data) {
  var i, len, results, v;
  data = (JSON.parse(data)).programmers;
  results = [];
  for (i = 0, len = data.length; i < len; i++) {
    v = data[i];
    results.push(console.log("First file contents:\nName: %s\nSex: %s\nDob: %s %s %s (age %s)\nSkills:%s\n", v.name, v.sex, v.dob.day, v.dob.month, v.dob.year, v.age, v.skills.map(function(a) {
      return ' ' + a;
    }).toString()));
  }
  return results;
})["catch"](function(err) {
  return console.log(err);
});

fs.readFilePromise(path.join(fs.realpathSync(__dirname), '../test/test')).then(function(data) {
  return console.log("Second file contents:\n" + data);
})["catch"](function(err) {
  return console.log(err);
});

console.log("Script works asynchronously. This message will be displayed before file contents output.\n");
