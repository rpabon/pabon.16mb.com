basePaths =
  src: './src'
  dest: './build'

config =
  paths:
    src: basePaths.src
    dest: basePaths.dest
    html:
      src: "#{basePaths.src}/jade/*.jade"
      dest: basePaths.dest
    css:
      src: "#{basePaths.src}/less/main.less"
      dest: "#{basePaths.dest}/css"
    js:
      src: "#{basePaths.src}/js/*.js"
      dest: "#{basePaths.dest}/js"
    img:
      src: "#{basePaths.src}/img/*.{png,jpg,gif}"
      dest: "#{basePaths.dest}/img"

module.exports = config
