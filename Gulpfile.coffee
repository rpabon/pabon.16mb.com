gulp = require 'gulp'
tasks = require('require-dir')('./gulp/tasks')
runSequence = require 'run-sequence'
concat = require 'gulp-concat'

gulp.task 'default', (done) ->
  runSequence 'clean', 'jade', 'less', done
