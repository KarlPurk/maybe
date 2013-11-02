describe "Maybe", ->

  it "should return deep value if it exists", ->
    person = address: state: 'NY'
    value = new Maybe(person).has('address').has('state').getValue()
    expect(value).toBe 'NY'

  it "should throw an exception if deep value does not exist", ->
    person = address: {}
    fn = -> new Maybe(person).has('address').has('state').getValue()
    expect(fn).toThrow()

  it "should not throw an exception if deep value does not exist and default has been specified", ->
    person = {}
    expected = 'Unknown'
    value = new Maybe(person).has('address').has('state', expected).getValue()
    expect(value).toBe expected

  it "should invoke error callback when value does not exist", ->
    person = address: {}
    called = false
    new Maybe(person).has('address').has('state').error( -> called = true)
    expect(called).toBe true

  it "should not invoke then callback when value does not exist", ->
    person = address: {}
    called = false
    new Maybe(person).has('address').has('state').then( -> called = true)
    expect(called).toBe false

  it "should invoke then callback when value does exist", ->
    person = address: state: 'NY'
    called = false
    state = 'Unknown'
    new Maybe(person).has('address').has('state').then(-> called = true)
    expect(called).toBe true

  it "should not invoke error callback when value does exist", ->
    person = address: state: 'NY'
    called = false
    new Maybe(person).has('address').has('state').error(-> called = true)
    expect(called).toBe false

  it "then should return value of last property selector", ->
    person = address: state: 'NY'
    state = 'Unknown'
    new Maybe(person).has('address').has('state').then((value) -> state = value)
    expect(state).toBe person.address.state

