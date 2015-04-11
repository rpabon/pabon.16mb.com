gulp = require 'gulp'
paths = require('../config').paths

gulp.task 'images', ->
  gulp.src paths.img.src
    .pipe gulp.dest paths.img.dest
