gulp = require 'gulp'
paths = require('../config').paths
clean = require 'del'

gulp.task 'clean', ->
  clean [paths.dest]
