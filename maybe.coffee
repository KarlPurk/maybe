class window.Maybe
  constructor: (value) ->
    @value = value
  isNothing: -> @
  isSomething: (cb) -> cb(@value); @
  error: -> @isNothing()
  then: (cb) -> @isSomething(cb)
  has: (property, defaultValue = null) ->
    unless @value?[property]?
      return new Nothing(defaultValue)
    new Maybe(@value[property])
  getValue: ->
    @value

class Nothing extends window.Maybe
  constructor: (value = null) ->
    super(value)
  isNothing: (cb) -> cb(); @
  isSomething: -> @
  error: (cb) -> @isNothing(cb)
  then: -> @isSomething()
  getValue: -> if @value? then return @value else throw Error('Nothing does not have a value')