gulp = require 'gulp'
coffee = require 'gulp-coffee'
newer = require 'gulp-newer'

gulp.task 'coffee', ->
	gulp.src 'src/*.coffee'
		.pipe newer 'src/*.coffee'
		.pipe coffee bare: true
		.pipe gulp.dest './'

gulp.task 'watch', ->
	gulp.watch 'src/*.coffee', ['coffee']

gulp.task 'default', ['watch']