class Ridenfly.RemoteLink
  constructor: (selector, @callback) ->
    @$el = $(selector)
    @$el.on 'click', @action

  action: (e) =>
    e.preventDefault()

    target = $(e.currentTarget)
    method = target.attr('data-remote-method')
    url    = target.attr('href')

    $.ajax
      url: url
      type: method || 'GET'
      dataType: 'text'
      cache: false
      processData: false
      success: (data, textStatus, jqXHR) =>
        paresedData = $.parseJSON(data)
        @response paresedData, target
        Ridenfly.Flash.success paresedData.message if paresedData.message?
      error: (jqXHR, textStatus, errorThrown) =>
        paresedData = $.parseJSON(jqXHR.responseText)
        @response paresedData, target
        Ridenfly.Flash.error paresedData.message if paresedData.message?

  response: (data, elem) ->
    @callback(data) if typeof @callback == 'function'
