
# global module: false
module.exports = (grunt) ->

  #global config
  globalConfig =
    src: "src"
    dest: "build"

  #load all grunt tasks
  require("load-grunt-tasks") grunt
  LIVERELOAD_PORT = 35729
  lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
  mountFolder = (connect, dir) ->
    connect.static require("path").resolve(dir)

  # Project configuration.
  grunt.initConfig
    globalConfig: globalConfig

    # Metadata.
    pkg: grunt.file.readJSON("package.json")
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today('yyyy-mm-dd') %>\n <%= pkg.homepage ? '* ' + pkg.homepage + '\\n' : '' %> * Copyright (c) <%= grunt.template.today('yyyy') %> <%= pkg.author %>; Licensed <%= pkg.license %> */\n"

    # clean destination folders
    clean:
      build: ["<%= globalConfig.dest %>"]

    # compile jade templates to HTML
    jade:
      dev:
        options:
          client: false
          pretty: true
          data:
            debug: false
        files: [
          cwd: "<%= globalConfig.src %>/jade"
          src: "*.jade"
          dest: "<%= globalConfig.dest %>"
          expand: true
          ext: ".html"
        ]

    # W3C HTML validation
    validation:
      options:
        path: "<%= globalConfig.dest %>/html-validation-results/status.json"
        reportpath: "<%= globalConfig.dest %>/html-validation-results/report.json"
        reset: grunt.option("reset") or false
        stoponerror: false
        relaxerror: [
          "Bad value X-UA-Compatible for attribute http-equiv on element meta."
          "Attribute intent not allowed on element img at this point."
          "Attribute in-highres-src not allowed on element img at this point."
        ]
      dev:
        files:
          src: ["<%= globalConfig.dest %>/*.html"]

    # compile SASS to CSS using Compass
    compass:
      prod:
        options:
          sassDir: "<%= globalConfig.src %>/sass"
          cssDir: "<%= globalConfig.dest %>/css"
          outputStyle: "compressed"
          environment: "production"
      dev:
        options:
          sassDir: "<%= globalConfig.src %>/sass"
          cssDir: "<%= globalConfig.dest %>/css"

    coffee:
      dev:
        options:
          bare: true
        files:
          "<%= globalConfig.dest %>/js/main.js": ["<%= globalConfig.src %>/coffee/*.coffee"]
      prod:
        options:
          join: true
        files:
          "<%= globalConfig.dest %>/js/main.js": ["<%= globalConfig.src %>/coffee/*.coffee"]
      glob_to_multiple:
        expand: true
        flatten: true
        cwd: "<%= globalConfig.src %>/coffee"
        src: ["*.coffee"]
        dest: "<%= globalConfig.dest %>/js"
        ext: ".js"

    # concatenate JavaScript files; done just for development
    concat:
      options:
        banner: "<%= banner %>"
        stripBanners: true
      vendor:
        src: ['bower_components/jquery/jquery.js']
        dest: '<%= globalConfig.dest %>/js/vendor.js'

    # copy image assets from source to build folder
    copy:
      images:
        files: [
          expand: true
          cwd: "<%= globalConfig.src %>/img"
          src: ["**"]
          dest: "<%= globalConfig.dest %>/img"
        ]
      fonts:
        files: [
          expand: true
          cwd: "bower_components/fontawesome/fonts"
          src: ["**"]
          dest: "<%= globalConfig.dest %>/fonts"
        ]

    #remove unused CSS
    # uncss: {
    #   dist: {
    #     files: {
    #       '<%= globalConfig.dest %>/css/tidy.css': ['<%= globalConfig.dest %>/index.html']
    #     }
    #   }
    # },

    #minify CSS
    # cssmin: {
    #   combine: {
    #     files: {
    #       '<%= globalConfig.dest %>/css/main.css': ['<%= globalConfig.dest %>/css/main.css']
    #     }
    #   }
    # },

    # minify images; done just for production
    imagemin:
      img:
        files: [
          expand: true
          cwd: "<%= globalConfig.src %>/img/"
          src: ["**/*.{png,jpg,gif}"]
          dest: "<%= globalConfig.dest %>/img/"
        ]

    # watch for changes in files; done just for development
    watch:
      options:
        livereload: LIVERELOAD_PORT
      jade:
        files: "<%= globalConfig.src %>/jade/**/*.jade"
        tasks: ["jade"]
      coffee:
        files: "<%= globalConfig.src %>/coffee/**/*.coffee"
        tasks: ["coffee:dev"]
      compass:
        files: "<%= globalConfig.src %>/sass/**/*.{sass,scss}"
        tasks: ["compass:dev"]
      img:
        files: "<%= globalConfig.src %>/img/**/*.{png,jpg,gif}"
        tasks: ["copy"]

    # connect to localhost server; done just for development
    connect:
      options:
        port: 9000
        hostname: "localhost"
      dev:
        options:
          middleware: (connect) ->
            [
              lrSnippet
              mountFolder(connect, "build")
            ]

    # open the local server; done just for development
    open:
      dev:
        path: "http://<%= connect.options.hostname %>:<%= connect.options.port %>/"

    # FTP deploy
    "ftp-deploy":
      build:
        auth:
          host: "ftp.pabon.16mb.com"
          port: 21
          authKey: "key1" #see .ftppass
        src: "<%= globalConfig.dest %>"
        dest: "/test"
        exclusions: ["<%= globalConfig.dest %>/html-validation-results"]

  # register grunt tasks
  grunt.registerTask "default", [
    "clean"
    "jade"
    "copy"
  ]

  grunt.registerTask "dev", [
    "default"
    "compass:dev"
    "coffee:dev"
    "concat"
    "connect"
    "open"
    "watch"
  ]

  grunt.registerTask "prod", [ #TODO uncss
    "default"
    "validation"
    "less:prod"
    "uglify"
    "imagemin"
    "ftp-deploy"
  ]

  return
