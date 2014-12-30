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

  # $scope.addNewItem
  # ==================================
  describe '$scope.addNewItem', ->
    it 'Should add new item', ()->
      carlos         = 'Carlos Henrique'
      $scope.newItem = carlos
      $scope.addNewItem()

      expect($scope.items.length).toEqual 1
      expect($scope.items[0]).toEqual carlos
      expect($scope.newItem).toBeNull()

    it 'Should not add an empty item', ->
      emptyItem       = ''
      $scope.newItem  = emptyItem
      $scope.addNewItem()

      expect($scope.items.length).toEqual 0
      expect($scope.items[0]).toBeUndefined()

  # $scope.deleteItemByIndex
  # ==================================
  describe '$scope.deleteItemByIndex', ->
    it 'Should delete item by index', ()->

      $scope.items = ['Real Madrid', 'PSG']
      $scope.deleteItemByIndex(0)

      expect($scope.items.length).toEqual 1
      expect($scope.items[0]).toEqual 'PSG'


