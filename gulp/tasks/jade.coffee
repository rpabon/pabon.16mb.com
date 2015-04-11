gulp = require 'gulp'
paths = require('../config').paths
jade = require 'gulp-jade'

gulp.task 'jade', ->
  gulp.src paths.html.src
  .pipe jade {pretty: true}
  .pipe gulp.dest paths.html.dest
