class Ridenfly.Controllers.Admin.Reports.Companies.Index extends Ridenfly.Controllers.Base
  initialize: ->
    new Ridenfly.RemoteLink "a[data-action=show-reservations]", @onShowReservations
    new Ridenfly.RemoteLink "a[data-action=create-payment]", @onCreatePayment

  onShowReservations: (data) ->
    $("td[data-reservations-company-id=#{data.company_id}]").html data.html

  onCreatePayment: (data) ->
    console.log data
