class Ridenfly.Controllers.Admin.Import.Rates.Create extends Ridenfly.Controllers.Base
  initialize: () ->
    @view = new Ridenfly.Views.Admin.Import.RemoteForm('.rate-forms')
    @view.on('form:changed', @resetForms, @)

  resetForms: () ->
    @view.init()
