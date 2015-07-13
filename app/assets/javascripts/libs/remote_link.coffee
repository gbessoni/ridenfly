class Ridenfly.RemoteLink
  constructor: (selector, @callback) ->
    @$el = $(selector)
    console.log @$el
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
        @response data, target
      error: (jqXHR, textStatus, errorThrown) =>
        @response jqXHR.responseText, target

  response: (data, elem) ->
    @callback(data) if typeof @callback == 'function'
