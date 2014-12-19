gulp = require 'gulp'

gulp.task 'watch', ['browserSync'], ->
  gulp.watch './app/haml/**/*.haml',               ['haml']
  gulp.watch './app/stylesheets/**/*.{sass,scss}', ['sass']
  gulp.watch './app/images/**/*',                  ['images']