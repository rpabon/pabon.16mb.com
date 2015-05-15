gulp = require 'gulp'
paths = require('../config').paths
watch = require 'gulp-watch'
browserSync = require('browser-sync').create()
reload = browserSync.reload

gulp.task 'browser-sync', ->
  browserSync.init
    server:
      baseDir: paths.dest

gulp.task 'watch', ['browser-sync'], ->
  gulp.watch paths.less.src, ['less']
  .on 'change', reload
