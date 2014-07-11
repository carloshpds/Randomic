'use strict'

describe 'Service: FoodFactory', () ->

  # load the service's module
  beforeEach module 'publicApp'

  # instantiate service
  FoodFactory = {}
  beforeEach inject (_FoodFactory_) ->
    FoodFactory = _FoodFactory_

  it 'should do something', () ->
    expect(!!FoodFactory).toBe true
