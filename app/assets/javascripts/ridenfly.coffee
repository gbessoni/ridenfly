window.Ridenfly =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Controllers:
    Admin: {}

  initialize: ->
    factory = new Ridenfly.ClassFactory(gon.controller)
    factory.controller()
