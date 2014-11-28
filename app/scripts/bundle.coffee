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

require './routes/routes'
# /*=============================
# =            React            =
# =============================*/

# /*==========  Components  ==========*/

require './react/components/basket/button'
require './react/components/basket/popup'
require './react/components/product/add_to_basket_button'
require './react/components/instagram/instagram'

require './react/dispatchers/basket'
require './react/actions/view/basket'
require './react/stores/basket'

# /*-----  End of React  ------*/

window.ReactUjs.initialize()