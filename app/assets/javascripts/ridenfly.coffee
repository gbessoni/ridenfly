window.Ridenfly =
  Models: {}
  Collections: {}
  Views:
    Admin:
      Import: {}
  Routers: {}
  Controllers:
    Admin:
      Reports:
        Companies: {}
      Import:
        Rates: {}
      Payments: {}
      Reservations: {}

  initialize: ->
    factory = new Ridenfly.ClassFactory(gon.controller)
    factory.controller()
    @initDateTimePicker()

  initDateTimePicker: ->
    $('.datepicker').datetimepicker()

    $('.datetimepicker').datetimepicker
      pickSeconds: false
