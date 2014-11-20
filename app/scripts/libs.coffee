window._                 = require 'lodash'
window.$ = window.jQuery = require 'jquery'
window.React             = require 'react'
window.ReactUjs          = require 'reactUjs'
window.Dispatcher        = require('flux').Dispatcher
window.EventEmitter      = require 'eventEmitter'
window.accounting        = require 'accounting'

# jQuery plugins
require 'jquery.role'
require 'jquery.mmenu'

# Others
require('react-mixin-manager')(window.React)
require 'bootstrapSass'
require 'owlCarousel'
require 'fancybox'
require 'fancybox.wannabe'

window.accounting.settings =
  currency:
    symbol:    'руб.'    # // default currency symbol is '$'
    format:    '%v %s'  # // controls output: %s = symbol, %v = value/number (can be object: see below)
    decimal:   ','     # // decimal point separator
    thousand:  ' '    # // thousands separator
    precision: 0     # // decimal places
  number:
    precision: 0     # // default precision on numbers is 0
    thousand:  ''
    decimal:   ','