jQuery = require 'jquery'
window.jQuery = jQuery
require 'jquery/dist/jquery'
require 'bootstrap-sass-official/assets/javascripts/bootstrap.js'
require 'jquery.role/lib/role.js'
require 'jQuery.mmenu/src/js/jquery.mmenu.min.all.js'
require 'OwlCarousel/owl-carousel/owl.carousel.js'
require 'fancybox/source/jquery.fancybox.js'
require 'fancybox/source/helpers/jquery.fancybox-thumbs.js'
window.accounting = require 'accounting.js/accounting.js'
window.accounting.settings =
  currency:
    symbol: "руб."    # // default currency symbol is '$'
    format: "%v %s"  # // controls output: %s = symbol, %v = value/number (can be object: see below)
    decimal: ","     # // decimal point separator
    thousand: " "    # // thousands separator
    precision: 0     # // decimal places
  number:
    precision: 0     # // default precision on numbers is 0
    thousand: ""
    decimal: ","

window.React = require 'react/addons'
require('react-mixin-manager')(window.React)
window.Dispatcher = require('flux').Dispatcher
window.EventEmitter = require 'eventEmitter'

