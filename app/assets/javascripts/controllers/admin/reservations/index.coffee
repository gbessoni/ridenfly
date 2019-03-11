class Ridenfly.Controllers.Admin.Reservations.Index extends Ridenfly.Controllers.Base
  initialize: ->
    $(".pickup-data-presets a").on 'click', @onClickDataPresets

  onClickDataPresets: (e) ->
    e.preventDefault()
    target = $(e.currentTarget)
    start_date = target.attr('data-start-date')
    end_date = target.attr('data-end-date')

    $("#q_pickup_datetime_start_date_gteq").val(start_date).trigger('change')
    $("#q_pickup_datetime_end_date_lteq").val(end_date).trigger('change')
