class Ridenfly.Controllers.Base
  constructor: () ->
    @initialize.apply @, arguments

  initialize: () ->
    # can be used in subclass
