var existsPromise, fs, openPromise, readFilePromise, readPromise, statPromise;

fs = require('fs');


/*
 * Check given file exists
 *
 * @param string path Path to file
 *
 * @see for more information about fs.exists visit: https://iojs.org/api/fs.html#fs_fs_exists_path_callback
 *
 * @return object Promise
 */

existsPromise = function(path) {
  return new Promise(function(_resolve, _reject) {
    return fs.exists(path, function(exists) {
      if (!exists) {
        return _reject(exists);
      }
      return _resolve(exists);
    });
  });
};


/*
 * Stat
 *
 * @param string path Path to file
 *
 * @see for more information about fs.stat visit: https://iojs.org/api/fs.html#fs_fs_stat_path_callback
 *
 * @return object Promise
 */

statPromise = function(path) {
  return new Promise(function(_resolve, _reject) {
    return fs.stat(path, function(err, stats) {
      if (err) {
        return _reject(err);
      }
      return _resolve(stats);
    });
  });
};


/*
 * Read given file with Promise
 *
 * @param int fd File descriptor
 * @param object buffer Buffer
 * @param int offset Offset in the buffer to start reading at
 * @param int length Number of bytes to read
 * @param null|int position
 *
 * @see for more information about fs.read visit: https://iojs.org/api/fs.html#fs_fs_read_fd_buffer_offset_length_position_callback
 *
 * @return object Promise
 */

readPromise = function(fd, buffer, offset, length, position) {
  return new Promise(function(_resolve, _reject) {
    return fs.read(fd, buffer, offset, length, position, function(err, bytesRead, buffer) {
      if (err) {
        return _reject(err);
      }
      _resolve(buffer);
    });
  });
};


/*
 * Open given file with promise
 *
 * @param string path Path to file
 * @param string flags
 * @param null|string mode sets the file mode (permission and sticky bits), but only if the file was created. It defaults to 0666, readable and writeable.
 *
 * @see for more information about fs.open visit: https://nodejs.org/api/fs.html#fs_fs_open_path_flags_mode_callback
 *
 * @return object Promise
 */

openPromise = function(path, flags, mode) {
  return new Promise(function(_resolve, _reject) {
    return fs.open(path, flags, mode, function(err, fd) {
      if (err) {
        return _reject(err);
      }
      return _resolve(fd);
    });
  });
};


/*
 * Read given file using promises
 * 
 * @param string path
 *
 * @return object Promise
 */

readFilePromise = function(path) {
  return new Promise(function(_resolve, _reject) {
    return existsPromise(path).then(function() {
      return statPromise(path).then(function(stats) {
        return openPromise(path, 'r', null).then(function(fd) {
          var buffer;
          buffer = new Buffer(stats.size);
          return readPromise(fd, buffer, 0, buffer.length, null).then(function(buffer) {
            return _resolve(buffer);
          })["catch"](function(err) {
            return _reject(err);
          });
        })["catch"](function(err) {
          return _reject(err);
        });
      });
    })["catch"](function() {
      return _reject("Unable to find " + path + " file. Wrong path?");
    });
  });
};

module.exports = fs;

module.exports.existsPromise = existsPromise;

module.exports.statPromise = statPromise;

module.exports.readPromise = readPromise;

module.exports.openPromise = openPromise;

module.exports.readFilePromise = readFilePromise;
