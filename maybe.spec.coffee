describe "maybe", ->

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

  it "should invoke isNothing callback when value does not exist", ->
    person = address: {}
    called = false
    new Maybe(person).has('address').has('state').isNothing( -> called = true)
    expect(called).toBe true

  it "should not invoke isSomething callback when value does not exist", ->
    person = address: {}
    called = false
    new Maybe(person).has('address').has('state').isSomething( -> called = true)
    expect(called).toBe false

  it "should invoke isSomething callback when value does exist", ->
    person = address: state: 'NY'
    called = false
    state = 'Unknown'
    new Maybe(person).has('address').has('state').isSomething((value) -> called = true)
    expect(called).toBe true

  it "should not invoke isNothing callback when value does exist", ->
    person = address: state: 'NY'
    called = false
    new Maybe(person).has('address').has('state').isNothing( -> called = true)
    expect(called).toBe false

  it "isSomething should return value of last property selector", ->
    person = address: state: 'NY'
    state = 'Unknown'
    new Maybe(person).has('address').has('state').isSomething((value) -> state = value)
    expect(state).toBe person.address.state