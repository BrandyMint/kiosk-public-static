"use strict"

# Load plugins
handleError = (err) ->
  console.warn err
  @emit "end"
gulp = require("gulp")

path = require("path")
sass = require('gulp-sass')
haml = require('gulp-haml-coffee')
flatten = require('gulp-flatten')
include = require('gulp-file-include')
autoprefixer = require('gulp-autoprefixer')

$ = require("gulp-load-plugins")()
sourcemaps = require("gulp-sourcemaps")

options = {}

# Scripts
gulp.task "scripts", ->
  
  #.pipe($.jshint('.jshintrc'))
  #.pipe($.jshint.reporter('default'))
  gulp.src("app/scripts/app.coffee",
    read: false
  )
    .pipe($.browserify(
      insertGlobals: true
      extensions: [
        ".coffee"
        ".csjx"
        ".js.jsx.coffee"
      ]
      transform: [
        "coffeeify"
        "reactify"
        "debowerify"
      ]
      shim:
        'bootstrap':
          path: 'app/bower_components/bootstrap-sass-official/assets/javascripts/bootstrap.js'
          exports: 'bootstrap'
          depends:
            'jquery': '$'
        'jquery.role':
          path: 'app/bower_components/jquery.role/lib/role.js'
          exports: null
          depends:
            'jquery': '$'

    ))
    .on("error", handleError)
    .pipe($.rename("bundle.js"))
    .pipe(gulp.dest("dist/scripts"))
    .pipe($.size())
    .pipe $.connect.reload()


#less_pipe = $.less(paths: [path.join(__dirname, "less", "includes")])
#sass_pipe = $.sass(paths: [path.join(__dirname, "sass", "includes")])

options.sass =
  errLogToConsole: true
  sourceComments: 'normal'
  includePaths: ['app/stylesheets/', 'app/bower_components/', 'app/bower_components/bootstrap-sass-official/assets/stylesheets/bootstrap']

gulp.task "sass", ->
  gulp
    .src("./app/stylesheets/app.scss")
    .pipe(sass(options.sass))
    .pipe(gulp.dest("dist/stylesheets"))
    .pipe($.connect.reload())
    .on "error", $.util.log
  return

options.prefixer =
  browsers: ['last 2 versions']
  cascade: false

gulp.task "prefixer", ->
  gulp
    .src("./dist/stylesheets/app.css")
    .pipe(autoprefixer(options.prefixer))
    .pipe(gulp.dest("dist/stylesheets"))

gulp.task "jade", ->
  gulp
    .src("app/template/*.jade")
    .pipe($.jade(pretty: true))
    .pipe(gulp.dest("dist"))
    .pipe $.connect.reload()


gulp.task "fonts", ->
  gulp
    .src("app/**/*.{eot,svg,ttf,woff}")
    .pipe(flatten())
    .pipe(gulp.dest("dist/fonts"))
    .pipe $.connect.reload()


gulp.task "assets", ->
  gulp
    .src("app/{api,stylesheets,includes,fonts}/**/*.{less,sass,scss,css,json,html,haml,js,eot,svg,ttf,woff}")
    .pipe gulp.dest("dist/")

# HTML
gulp.task "html", ->
  gulp
    .src("app/*.html")
    .pipe($.useref())
    .pipe(gulp.dest("dist"))
    .pipe($.size())
    .pipe($.connect.reload())
    .on "error", $.util.log

gulp.task "haml", ->
  gulp
    .src("app/**/*.haml")
    .pipe(include(
      prefix: "@@"
      basepath: "@file"
    ))
    .pipe(haml())
    .pipe(gulp.dest("dist"))
    .pipe($.connect.reload())
    .on "error", $.util.log
  return

# Images
gulp.task "images", ->
  
  #.pipe($.cache($.imagemin({
  #optimizationLevel: 3,
  #progressive: true,
  #interlaced: true
  #})))
  gulp
    .src("app/images/**/*")
    .pipe(gulp.dest("dist/images"))
    .pipe($.size())
    .pipe $.connect.reload()


# Clean
gulp.task "clean", ->
  gulp.src("dist",
    read: false
  ).pipe $.clean()


gulp.task "styles", ["sass", "prefixer"]

# Bundle
gulp.task "bundle", [
  "assets"
  "scripts"
  "styles"
  "bower"
], $.bundle("./app/*.html")

# Build
gulp.task "build", [
  "html"
  "haml"
  "bundle"
  "images"
  "fonts"
]

# Default task
gulp.task "default", ["clean"], ->
  gulp.start "build"
  return


# Connect
gulp.task "connect", $.connect.server(
  root: ["dist"]
  port: 9000
  livereload: true
)

# Bower helper
gulp.task "bower", ->
  gulp.src("app/bower_components/**/*.{js,css}",
    base: "app/bower_components"
  ).pipe gulp.dest("dist/bower_components/")
  return

gulp.task "json", ->
  gulp.src("app/scripts/json/**/*.json",
    base: "app/scripts"
  ).pipe gulp.dest("dist/scripts/")
  return


# Watch
gulp.task "watch", [
  "images"
  "fonts"
  "assets"
  "html"
  "haml"
  "bundle"
  "connect"
], ->
  
  # Watch .json files
  #gulp.watch('app/scripts/**/*.json', ['json']);
  
  # Watch .html files
  gulp.watch "app/*.html", ["html"]
  gulp.watch "app/**/*.haml", ["haml"]
 
  # Watch .jade files
  #gulp.watch('app/template/**/*.jade', ['jade', 'html']);
  
  # Watch .coffeescript files
  #gulp.watch('app/scripts/**/*.coffee', ['coffee', 'scripts']);
  gulp.watch "app/scripts/**/*.coffee", ["scripts"]
  gulp.watch "app/stylesheets/**/*.css", ["assets"]
  gulp.watch "app/stylesheets/**/*.sass", ["sass"]
  gulp.watch "app/stylesheets/**/*.scss", ["sass"]
 
  # Watch .jsx files
  # gulp.watch('app/scripts/**/*.jsx', ['jsx', 'scripts']);
  
  # Watch .js files
  gulp.watch "app/scripts/**/*.js", ["scripts"]
  
  # Watch image files
  gulp.watch "app/images/**/*", ["images"]
  return

