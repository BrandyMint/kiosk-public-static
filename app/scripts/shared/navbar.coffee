$ ->
  #Navbar sticking on scroll
  stickyOptions = 
    getWidthFrom: $('.navbar-collapse')
  
  $('.categories-nav').sticky stickyOptions