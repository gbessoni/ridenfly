window.Ridenfly =
  Models: {}
  Collections: {}
  Views:
    Admin:
      Import: {}
  Routers: {}
  Controllers:
    Admin:
      Import:
        Rates: {}

  initialize: ->
    factory = new Ridenfly.ClassFactory(gon.controller)
    factory.controller()
