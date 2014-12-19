src   = './app'
build = './build'
dist  = './dist'

module.exports = {
  clean: {
    dest: [build, dist]
  }
  browserSync: {
    port: 9000
    open: false
    server: {
      baseDir: [build, src]
    }
    files: [build + '/**']
  }
  local: {
    scripts: {
      vendor: {
        baseDir: src + '/bower_components'
        dest: build + '/scripts'
        outputName: 'vendor.js'
        extensions: ['.coffee']
      }
      client: {
        entries: src + '/scripts/main.coffee'
        dest: build + '/scripts'
        outputName: 'client.js'
        extensions: ['.coffee', '.js.jsx.coffee']
      }
    }
    haml: {
      src: 'app/haml/**/*.haml'
      dest: build
    }
    sass: {
      src: src + '/stylesheets/main.scss'
      dest: build + '/stylesheets'
      outputName: 'local.css'
    }
    fonts: {
      src: src + '/**/*.{ttf,woff,eof,eot,svg}'
      dest: build + '/fonts'
    }
    images: {
      src: src + '/images/**/*'
      dest: build + '/images'
    }
  }
  production: {
    scripts: {
      bundle: {
        baseDir: src
        entries: './scripts/bundle.coffee'
        extensions: ['.coffee', '.js.jsx.coffee']
        dest: dist + '/scripts/'
        outputName: 'bundle.js'
      }
      minify: {
        src: dist + '/scripts/bundle.js'
        dest: dist + '/scripts'
        outputName: 'bundle.min.js'
      }
    }
    styles: {
      bundle: {
        src: src + '/stylesheets/bundle.scss'
        dest: dist + '/stylesheets'
        outputName: 'bundle.css'
      }
      minify: {
        src: dist + '/stylesheets/bundle.css'
        dest: dist + '/stylesheets'
        outputName: 'bundle.min.css'
      }
    }
  }
}