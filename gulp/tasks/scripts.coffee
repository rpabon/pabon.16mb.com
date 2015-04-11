gulp = require 'gulp'
paths = require('../config').paths
concat = require 'gulp-concat'
jshint = require 'gulp-jshint'

vendorFiles = [
  'bower_components/jquery/jquery.js'
  'bower_components/jqueryui/ui/jquery.ui.core.js' #dependency for draggable
  'bower_components/jqueryui/ui/jquery.ui.widget.js' #dependency for draggable
  'bower_components/jqueryui/ui/jquery.ui.mouse.js' #dependency for draggable
  'bower_components/jqueryui/ui/jquery.ui.draggable.js' #draggable
  'bower_components/jqueryui/ui/jquery.ui.effect.js' #easing
  'bower_components/hoverintent/jquery.hoverIntent.js' #hover intent
  'bower_components/underscore/underscore.js' # dependency of intentionjs
  'bower_components/intentionjs/intention.js' # support of retina images
  'bower_components/intentionjs/context.js' # support of retina images
]

gulp.task 'scripts:vendor', ->
  gulp.src vendorFiles
  .pipe concat('vendor.js')
  .pipe gulp.dest paths.js.dest

gulp.task 'scripts:main', ->
  gulp.src paths.js.src
  .pipe concat('main.js')
  .pipe jshint()
  .pipe gulp.dest paths.js.dest

gulp.task 'scripts', ['scripts:vendor', 'scripts:main']
