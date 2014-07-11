'use strict'

describe 'Service: pizzaFactory', () ->

  # load the service's module
  beforeEach module 'publicApp'

  # instantiate service
  pizzaFactory = {}
  beforeEach inject (_pizzaFactory_) ->
    pizzaFactory = _pizzaFactory_

  it 'should do something', () ->
    expect(!!pizzaFactory).toBe true
