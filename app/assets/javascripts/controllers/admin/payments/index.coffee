class Ridenfly.Controllers.Admin.Payments.Index extends Ridenfly.Controllers.Base
  initialize: ->
    console.log 'here'
    $("input[data-payment-url]").on 'change', @onPaidChange

  onPaidChange: (e) ->
    target = $(e.currentTarget)
    $.ajax
      url: target.attr('data-payment-url')
      type: 'PUT'
      data:
        payment:
          paid: target.is(':checked')
