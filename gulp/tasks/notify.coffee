gulp = require 'gulp'
paths = require('../config').paths
notify = require 'gulp-notify'

defaultMsg = 'Default tasks completed! Watching...'

gulp.task 'notify', ->
  gulp.src paths.src
  .pipe notify
    message: defaultMsg
    onLast: true