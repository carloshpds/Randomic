'use strict'

describe 'Service: IngredientFactory', () ->

  # load the service's module
  beforeEach module 'publicApp'

  # instantiate service
  IngredientFactory = {}
  beforeEach inject (_IngredientFactory_) ->
    IngredientFactory = _IngredientFactory_

  it 'should do something', () ->
    expect(!!IngredientFactory).toBe true
