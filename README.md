# Maybe.js

An implementation of the Maybe Monad written in CoffeeScript.

# Basic usage

**Example One**: Return the value of a property
```coffee
person = address: state: 'NY'
value = new Maybe(person).has('address').has('state').getValue()
value is 'NY' # true
```

**Example Two**: Return a default value when the property does not exist
```coffee
person = {}
value = new Maybe(person).has('address').has('state', 'Unknown').getValue()
value is 'Unknown' # true
```

# Using callbacks

**Example One**: Invoke a callback when the property you request does exist
```coffee
person = address: state: 'NY'
new Maybe(person).has('address').has('state').error(-> console.log 'not called').then((value) -> console.log value)
# 'NY' is logged to the console
```

**Example Two**: Invoke a callback when the property you request does not exist
```coffee
person = {}
new Maybe(person).has('address').has('state').error(-> console.log 'error occurred').then((value) -> console.log 'not called')
# 'error occurred' is logged to the console
```
