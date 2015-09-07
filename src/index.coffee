# Requiring standart fs module
fs = require 'fs'

###
# Check given file exists
#
# @param string path Path to file
#
# @see for more information about fs.exists visit: https://iojs.org/api/fs.html#fs_fs_exists_path_callback
#
# @return object Promise
###
existsPromise = (path) ->
	return new Promise (_resolve, _reject) ->
		fs.exists path, (exists) ->
			unless exists
				return _reject exists
			return _resolve exists
###
# Stat
#
# @param string path Path to file
#
# @see for more information about fs.stat visit: https://iojs.org/api/fs.html#fs_fs_stat_path_callback
#
# @return object Promise
###
statPromise = (path) ->
	return new Promise (_resolve, _reject) ->
		fs.stat path, (err, stats) ->
			if err
				return _reject err
			return _resolve stats
###
# Read given file with Promise
#
# @param int fd File descriptor
# @param object buffer Buffer
# @param int offset Offset in the buffer to start reading at
# @param int length Number of bytes to read
# @param null|int position
#
# @see for more information about fs.read visit: https://iojs.org/api/fs.html#fs_fs_read_fd_buffer_offset_length_position_callback
#
# @return object Promise
###
readPromise = (fd, buffer, offset, length, position) ->
	return new Promise (_resolve, _reject) ->
		fs.read fd, buffer, offset, length, position, (err, bytesRead, buffer) ->
			if err
				return _reject err
			_resolve buffer
			# fs.close fd
			return

###
# Open given file with promise
#
# @param string path Path to file
# @param string flags
# @param null|string mode sets the file mode (permission and sticky bits), but only if the file was created. It defaults to 0666, readable and writeable.
#
# @see for more information about fs.open visit: https://nodejs.org/api/fs.html#fs_fs_open_path_flags_mode_callback
#
# @return object Promise
###
openPromise = (path, flags, mode) ->
	return new Promise (_resolve, _reject) ->
		# fs.exists path, (exists) ->
		# 	unless exists
		# 		return _reject "File not exists"
		# 	fs.stat path, (err, stats) ->
		# 		if err
		# 			return _reject err
		# 		fs.open path, 'r', (err, fd) ->
		# 			if err
		# 				return _reject err
		# 			buffer = new Buffer stats.size
		# 			fs.read fd, buffer, 0, buffer.length, null, (err, bytesRead, buf) ->
		# 				return _resolve buffer
		fs.open path, flags, mode, (err, fd) ->
			if err
				return _reject err
			return _resolve fd

###
# Read given file using promises
# 
# @param string path
#
# @return object Promise
###
readFilePromise = (path) ->
	# return new Promise (_resolve, _reject) ->
	# 	existsPromise path
	# 	.then ->
	# 		statPromise path
	# 		.then (stats) ->
	# 			openPromise path, 'r', null
	# 			.then (fd) ->
	# 				buffer = new Buffer stats.size
	# 				readPromise fd, buffer, 0, buffer.length, null
	# 				.then (buffer) ->
	# 					_resolve buffer
	# 				.catch (err) ->
	# 					_reject err
	# 			.catch (err) ->
	# 				_reject err
	# 	.catch ->
	# 		_reject "Unable to find #{path} file. Wrong path?"
	return new Promise (_resolve, _reject) ->
		fs.readFile path, (err, data) ->
			if err
				_reject err
			else
				_resolve data

###
# Write file using native promises
#
# @param string filename
# @param Buffer|string data
# @param object|string
# 			- string|null encoding
#			- number mode
# 			- string flag
###
writeFilePromise = (filename, data, options) ->
	return new Promise (_resolve, _reject) ->
		fs.writeFile filename, data, options, (err) ->
			if err
				_reject err

appendFilePromise = (filename, data, options) ->
	return new Promise (_resolve, _reject) ->
		fs.appendFile filename, data, options, (err) ->
			if err
				_reject err

module.exports = fs
module.exports.existsPromise = existsPromise
module.exports.statPromise = statPromise
module.exports.readPromise = readPromise
module.exports.openPromise = openPromise
module.exports.readFilePromise = readFilePromise
module.exports.writeFilePromise = writeFilePromise
