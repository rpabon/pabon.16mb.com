gulp = require 'gulp'
paths = require('../config').paths
less = require 'gulp-less'

gulp.task 'less', ->
  gulp.src paths.less.srcMain
  .pipe less()
  .pipe gulp.dest paths.less.dest
