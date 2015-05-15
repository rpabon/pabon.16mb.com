gulp = require 'gulp'
tasks = require('require-dir')('./gulp/tasks')
runSequence = require 'run-sequence'

gulp.task 'default', (done) ->
  runSequence(
    'clean'
    'copy'
    'jade'
    'less'
    'scripts'
    'watch'
    'notify'
    done)
