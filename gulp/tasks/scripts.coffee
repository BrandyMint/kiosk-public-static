browserify   = require 'browserify'
gulp         = require 'gulp'
source       = require 'vinyl-source-stream'
bundleLogger = require '../util/bundleLogger'
handleErrors = require '../util/handleErrors'
config       = require('../config').production.scripts.bundle

gulp.task 'scripts', ->
  bundler = browserify({
    cache: {}, packageCache: {}
    basedir: config.baseDir
    entries: config.entries
    extensions: config.extensions
  }).require './bower_components/jquery/dist/jquery',                                   { expose: 'jquery' }
    .require './bower_components/bootstrap-sass-official/assets/javascripts/bootstrap', { expose: 'bootstrapSass' }
    .require './bower_components/jquery.role/lib/jquery.role',                          { expose: 'jquery.role' }
    .require './bower_components/jQuery.mmenu/src/js/jquery.mmenu.min.all',             { expose: 'jquery.mmenu' }
    .require './bower_components/react/react-with-addons',                              { expose: 'react' }
    .require './bower_components/react-mixin-manager/react-mixin-manager',              { expose: 'react-mixin-manager' }
    .require './scripts/resources/react_ujs',                                           { expose: 'reactUjs' }
    .require './bower_components/eventEmitter/EventEmitter',                            { expose: 'eventEmitter' }
    .require './bower_components/OwlCarousel/owl-carousel/owl.carousel',                { expose: 'owlCarousel' }
    .require './bower_components/fancybox/source/jquery.fancybox',                      { expose: 'fancybox' }
    .require './bower_components/fancybox-wannabe-fix/index',                           { expose: 'fancybox.wannabe' }
    .require './bower_components/accounting.js/accounting',                             { expose: 'accounting' }
    .require './bower_components/lodash/dist/lodash',                                   { expose: 'lodash' }

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