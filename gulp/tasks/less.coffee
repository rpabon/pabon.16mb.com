gulp = require 'gulp'
paths = require('../config').paths
less = require 'gulp-less'

gulp.task 'less', ->
  gulp.src paths.css.src
  .pipe less()
  .pipe gulp.dest paths.css.dest
