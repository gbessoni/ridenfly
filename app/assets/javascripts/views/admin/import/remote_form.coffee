class Ridenfly.Views.Admin.Import.RemoteForm extends Backbone.View
  constructor: (@el) ->
    @init()

  init: () ->
    @form = $(@el).find('form')
    @form.off('submit')
    @form.submit @submitEvent
    @bindSaveAll()

  submitEvent: (e) =>
    e.preventDefault()
    form = $(e.target)
    $.post(
      form.attr('action'),
      form.serialize(),
      ((data) =>
        form.replaceWith(data)
        @trigger('form:changed')),
      'text'
    )

  bindSaveAll: ->
    $('.save_all').on 'click', =>
      @form.each ->
        $('form', @).submit()
