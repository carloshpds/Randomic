'use strict'

# =============================================
# RandomController
# =============================================
describe 'Controller: RandomController', ()->

  # =============================================
  # Import modules
  # =============================================
  beforeEach module('ui.router')
  beforeEach module('ui.bootstrap')
  beforeEach module('RandomicApp.scripts')
  beforeEach module('stateMock')

  # =============================================
  # Variables
  # =============================================
  $scope            = null
  RandomController  = null

  # =============================================
  # Inject dependencies
  # =============================================
  beforeEach inject ($controller, $rootScope, _$state_) ->
    $scope            = $rootScope.$new()
    RandomController  = $controller 'RandomController',
      $scope: $scope
      $state: _$state_


  # =============================================
  # Tests
  # =============================================
  describe '$scope.resetRandomItems', ->
    it 'Should reset randomItems array', ->
      $scope.randomItems = ['randomItem1', 'randomItem2', 'randomItem3']
      $scope.resetRandomItems()

      expect($scope.randomItems.length).toEqual 0
      
      
    


