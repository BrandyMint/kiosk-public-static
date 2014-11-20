browserify     = require 'browserify'
gulp           = require 'gulp'
source         = require 'vinyl-source-stream'
bundleLogger   = require '../util/bundleLogger'
handleErrors   = require '../util/handleErrors'
config         = require('../config').local.scripts.vendor

gulp.task 'vendorScripts', ->
  bundler = browserify({
    cache: {}, packageCache: {}
    basedir: config.baseDir
    extensions: config.extensions
  }).require './jquery/dist/jquery',                                   { expose: 'jquery' }
    .require './bootstrap-sass-official/assets/javascripts/bootstrap', { expose: 'bootstrapSass' }
    .require './jquery.role/lib/jquery.role',                          { expose: 'jquery.role' }
    .require './jQuery.mmenu/src/js/jquery.mmenu.min.all',             { expose: 'jquery.mmenu' }
    .require './react/react-with-addons',                              { expose: 'react' }
    .require './react-mixin-manager/react-mixin-manager',              { expose: 'react-mixin-manager' }
    .require '../scripts/resources/react_ujs',                         { expose: 'reactUjs' }
    .require './eventEmitter/EventEmitter',                            { expose: 'eventEmitter' }
    .require './OwlCarousel/owl-carousel/owl.carousel',                { expose: 'owlCarousel' }
    .require './fancybox/source/jquery.fancybox',                      { expose: 'fancybox' }
    .require './fancybox-wannabe-fix/index',                           { expose: 'fancybox.wannabe' }
    .require './accounting.js/accounting',                             { expose: 'accounting' }
    .require './lodash/dist/lodash',                                   { expose: 'lodash' }

  bundle = ->
    bundleLogger.start config.outputName

    return bundler
             .bundle()
             .on 'error', handleErrors
             .pipe source(config.outputName)
             .pipe gulp.dest(config.dest)
             .on 'end', ->
               bundleLogger.end config.outputName

  return bundle()