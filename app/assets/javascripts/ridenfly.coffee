window.Ridenfly =
  Models: {}
  Collections: {}
  Views:
    Admin: {}
    Shared: {}
  Routers: {}
  Controllers:
    Admin:
      Import:
        Rates: {}

  initialize: ->
    factory = new Ridenfly.ClassFactory(gon.controller)
    factory.controller()
