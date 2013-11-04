[![Build Status](https://travis-ci.org/KarlPurk/jsmapper.png)](https://travis-ci.org/KarlPurk/maybe)
# Maybe.js

Is it a bird? Is it a plane? Is it a Maybe? Is it a Monad? Maybe.

```javascript
new Maybe(this).has('isMaybe').has('isMonad').getValue(); // Likely false
```

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
person = address: '129 Somewhere'
new Maybe(person).has('address').error(...).then((value) -> console.log value)
# '129 Somewhere' is logged to the console
```

**Example Two**: Invoke a callback when the property you request does not exist
```coffee
person = {}
new Maybe(person).has('address').error(-> console.log 'error occurred').then(...)
# 'error occurred' is logged to the console
```
