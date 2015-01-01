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
  describe 'Method: $scope.resetRandomItems', ->
    it 'Should reset randomItems array', ->
      $scope.randomItems = ['randomItem1', 'randomItem2', 'randomItem3']
      
      $scope.$digest()
      
      $scope.resetRandomItems()

      expect($scope.randomItems.length).toEqual 0


  describe 'Method: $scope.calcRandomCycleNumber', ->
    it 'Should calculate how much times we will iterate the items array to get a random item based on the sum of each timestamp numbers', ->
      timeStamp = ["1", "3", "6", "8"]
      randomCycleNumber = $scope.calcRandomCycleNumber(timeStamp)

      $scope.$digest()
      
      expect(randomCycleNumber).toEqual 18


  describe 'Method: $scope.getRandomItem', ->
    it 'Should get a random item from $scope.items by iterate calcRandomCycleNumber times and checking if the current timestamp is divisible by the current index', ->
      $scope.items = [
        {text: 'item1'}
        {text: 'item2'}
        {text: 'item3'}
      ]

      $scope.$digest()

      fakeTimestampFunction = () -> return 10
      randomItem            = $scope.getRandomItem(1, fakeTimestampFunction)
      

      expect(randomItem).toBeDefined() 
      expect(randomItem.text).toEqual 'item3'
      expect($scope.randomItems.length).toEqual 1



      
    

    

      
    


