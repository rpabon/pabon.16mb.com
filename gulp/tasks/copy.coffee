gulp = require 'gulp'
paths = require('../config').paths
imagemin = require 'gulp-imagemin'
pngquant = require 'imagemin-pngquant'

imgCompressOptions =
  progressive: true
  svgoPlugins: [{removeViewBox: false}]
  use: [pngquant()]

gulp.task 'copy:images', ->
  gulp.src paths.img.src
  .pipe imagemin imgCompressOptions
  .pipe gulp.dest paths.img.dest

gulp.task 'copy', ['copy:images']
