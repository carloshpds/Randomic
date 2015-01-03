'use strict'

# =============================================
# RandomController
# =============================================
describe 'Config: RandomRoutes', ()->

  # =============================================
  # Import modules
  # =============================================
  beforeEach module('ui.router')
  beforeEach module('RandomicApp.scripts')
  beforeEach module('stateMock')

  # =============================================
  # Variables
  # =============================================
  $state  = null

  # =============================================
  # Inject dependencies
  # =============================================
  beforeEach inject (_$state_) ->
    $state = _$state_

    _.mixin(_.string.exports())

  describe '$state', ->
    it 'should be sure of the state name', ->
      
      stateName = 'random'
  
      $state.expectTransitionTo stateName
      $state.go stateName
      allTransitionsHappened = $state.ensureAllTransitionsHappened()

      expect($state.current.name).toEqual stateName
      expect(allTransitionsHappened).toBeTruthy() 
      