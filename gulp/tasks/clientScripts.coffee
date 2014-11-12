browserify     = require 'browserify'
watchify       = require 'watchify'
gulp           = require 'gulp'
source         = require 'vinyl-source-stream'
bundleLogger   = require '../util/bundleLogger'
handleErrors   = require '../util/handleErrors'
config         = require('../config').local.scripts.client

gulp.task 'clientScripts', ->
  bundler = browserify({
    cache: {}, packageCache: {}
    entries: config.entries
    extensions: config.extensions
  }).external 'jquery'
    .external 'jquery.role'
    .external 'jquery.mmenu'
    .external 'bootstrapSass'
    .external 'react'
    .external 'react-mixin-manager'
    .external 'reactUjs'
    .external 'eventEmitter'
    .external 'owlCarousel'
    .external 'fancybox'
    .external 'fancybox.wannabe'
    .external 'accounting'

  bundle = ->
    bundleLogger.start config.outputName

    return bundler
             .bundle()
             .on 'error', handleErrors
             .pipe source(config.outputName)
             .pipe gulp.dest(config.dest)
             .on 'end', ->
               bundleLogger.end config.outputName

  bundler = watchify bundler
  bundler.on 'update', bundle

  return bundle()