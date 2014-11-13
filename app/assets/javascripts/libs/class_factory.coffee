class Ridenfly.ClassFactory
  constructor: (@name) ->

  controller: () ->
    klass = _.reduce @name.split('.'), (memo, curr) -> 
      if memo[curr]? then memo[curr] else {}
    , Ridenfly.Controllers
    new klass?()
