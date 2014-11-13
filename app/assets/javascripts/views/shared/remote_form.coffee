class Ridenfly.Views.Shared.RemoteForm
  constructor: (@el) ->
    @init()

  init: () ->
    @form = $(@el)
    @fields = @form
    @form.submit @submitEvent

  submitEvent: (e) =>
    e.preventDefault()
    $.post @form.attr('action'), @form.serialize(), @submitCallback, 'text'

  submitCallback: (data) =>
    if data.match /"ok"/
      @setLocation($.parseJSON(data).ok)
    else
      @fields.html(data)
      @invalidFormCallback()

  setLocation: (url) ->
    window.location = url

  invalidFormCallback: () ->
    