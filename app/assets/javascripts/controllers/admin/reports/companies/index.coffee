class Ridenfly.Controllers.Admin.Reports.Companies.Index extends Ridenfly.Controllers.Base
  initialize: ->
    new Ridenfly.RemoteLink 'a[data-company-id]', @callback

  callback: (data) ->

