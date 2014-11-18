require './libs'
require './shared/app'
require './shared/cart'
require './shared/load_more'
require './shared/lightbox'
require './shared/jump'
require './shared/product_images_slider'
require './shared/application_slider'
require './shared/theme_switcher'
require './shared/mobile_navigation'
require './shared/checkout'

# /*=============================
# =            React            =
# =============================*/

# /*==========  Components  ==========*/

require './react/components/basket/basket_button'
require './react/components/basket/basket_popup'


require './react/dispatchers/dispatcher'
require './react/actions/basket_action'
require './react/stores/basket_store'

# /*-----  End of React  ------*/

window.ReactUjs.initialize()