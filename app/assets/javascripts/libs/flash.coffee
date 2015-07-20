class Ridenfly.Flash
  @error: (msg) ->
    $('#main.container').prepend @alert msg, 'danger'

  @success: (msg) ->
    $('#main.container').prepend @alert msg

  @alert: (msg, type='success') ->
    "<div class='alert alert-#{type} alert-dismissable'>
      <button aria-hidden='true' class='close' data-dismiss='alert' type='button'>×</button>
      #{msg}
    </div>"
