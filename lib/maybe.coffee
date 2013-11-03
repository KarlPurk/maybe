###
  Eliminates the need for conditionals when retrieving properties from an object.
  Insprired by the Maybe Monad and this article:
  http://flippinawesome.org/2013/10/28/a-gentle-introduction-to-monads-in-javascript/
###
class window.Maybe

  ###
    Construct a new Maybe using the specified value.
  ###
  constructor: (value) ->
    @value = value

  ###
    Invokes specified callback when a value does not exist.
  ###
  error: (cb) -> @

  ###
    Invokes specified callback when a value exists.
  ###
  then: (cb) -> cb(@value); @

  ###
    Returns the value of the specified property as a new Maybe.
  ###
  has: (property, defaultValue = null) ->
    unless @value?[property]?
      return new Nothing(defaultValue)
    new Maybe(@value[property])

  ###
    Returns the value of the Maybe.
  ###
  getValue: ->
    @value

  ###
    Adds a new Maybe to the chain, permitting OR like logic.
  ###
  orMaybe: (value) ->
    # If we call onMaybe on a valid Maybe then we want to return
    # a new Something so that this Maybe's value is carried through
    # the execution chain to the getValue call
    new Something @value

###
  Carrries a value and allows the user to retrieve it.
  This is used with orMaybe and allows the first valid value to be carried
  through the call stack so that the last getValue call in the chain is able
  to return the first valid value found.
###
class Something extends window.Maybe
  constructor: (value) -> @value = value
  error: -> @
  then: -> @
  has: -> @

###
  Represents the absence of a property. Although nothing can still hold a value,
  this happens when the user specifies a default value.
###
class Nothing extends window.Maybe

  ###
    Construct a new Maybe that represents Nothing - optionally taking a value.
  ###
  constructor: (value = null) ->
    super(value)

  ###
    Invokes specified callback when a value does not exist.
  ###
  error: (cb) -> cb(); @

  ###
    Invokes specified callback when a value exists.  However, because this class represents
    Nothing the callback is never invoked - instead the error callback is invoked.
  ###
  then: -> @

  ###
    Returns the value of the Maybe.  In this case this Maybe represents Nothing, and so we
    throw a new Exception unless the user has provided a default value, in which case we
    return the default value instead.
  ###
  getValue: -> if @value? then return @value else throw Error('Nothing does not have a value')

  ###
    Adds a new Maybe to the chain, permitting OR like logic.
  ###
  orMaybe: (value) ->
    new Maybe value