fs = require './index'
path = require 'path'

# Read 1st file
fs.readFilePromise "#{__dirname}/test/file.json"
.then (data) -> 
	data = (JSON.parse data).programmers
	for v in data
		console.log "First file contents:\nName: %s\nSex: %s\nDob: %s %s %s (age %s)\nSkills:%s\n", v.name, v.sex, v.dob.day, v.dob.month, v.dob.year, v.age, v.skills.map((a) -> ' ' + a).toString()
.catch (err) ->
	console.log err

# Read 2nd file 
fs.readFilePromise "#{__dirname}/test/test"
.then (data) ->
	console.log "Second file contents:\n" + data
.catch (err) ->
	console.log err

fs.writeFilePromise "#{__dirname}/test/writtenWithPromise", process.argv[2..].toString(), 'utf-8'
.catch (err) ->
	console.log err

console.log "Script works asynchronously. This message will be displayed before file contents output.\n"