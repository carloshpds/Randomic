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

    _.mixin(_.string.exports())


  # =============================================
  # Tests
  # =============================================
  describe 'Method: $scope.resetRandomItems', ->
    it 'Should reset randomItems array', ->
      $scope.randomItems = ['randomItem1', 'randomItem2', 'randomItem3']
      
      $scope.$digest()
      
      $scope.resetRandomItems()

      expect($scope.randomItems.length).toEqual 0


  describe 'Method: $scope.calcTimestampSum', ->
    it 'Should calculate how much times we will iterate the items array to get a random item based on the sum of each timestamp numbers', ->
      timeStamp = ["1", "3", "6", "8"]
      randomCycleNumber = $scope.calcTimestampSum(timeStamp)

      $scope.$digest()
      
      expect(randomCycleNumber).toEqual 18


  describe 'Method: $scope.validateRandomItem', ->
    beforeEach ->
      $scope.randomItems = [
        { items: ['randomItem1', 'randomItem2'], text: 'randomItem1 and randomItem2'  }
      ]

    it 'Should return a valid for a not duplicate item when allowDuplicateItem flag is equal to false', ->
      $scope.randomForm.allowDuplicateItem = no
      
      $scope.$digest()
      
      isValidRandomItem = $scope.validateRandomItem('randomItem3')

      expect(isValidRandomItem).toBeTruthy()

    it 'Should return invalid for a duplicate random item when allowDuplicateItem flag is equal to false', ->
      $scope.randomForm.allowDuplicateItem = no
      
      $scope.$digest()
      
      isValidRandomItem = $scope.validateRandomItem('randomItem2')

      expect(isValidRandomItem).toBeFalsy()

    it 'Should return a valid for a not duplicate item when allowDuplicateItem flag is equal to true', ->
      $scope.randomForm.allowDuplicateItem = yes
      
      $scope.$digest()
      
      isValidRandomItem = $scope.validateRandomItem('randomItem3')

      expect(isValidRandomItem).toBeTruthy()

    it 'Should return valid for a duplicate random item when allowDuplicateItem flag is equal to true', ->
      $scope.randomForm.allowDuplicateItem = yes
      
      $scope.$digest()
      
      isValidRandomItem = $scope.validateRandomItem('randomItem2')

      expect(isValidRandomItem).toBeTruthy()


  describe 'Method: $scope.getRandomItemObj', ->
    it 'Should be sure that the random item is equal to a item from $scope.items choosen by a randomIndex when allows duplicate item', ->

      $scope.randomForm.allowDuplicateItem = yes
      $scope.items = [
        {text: 'item1'}
        {text: 'item2'}
        {text: 'item3'}
      ]
      $scope.$digest()

      randomItemObj = $scope.getRandomItemObj()

      expect(randomItemObj.item).toEqual $scope.items[randomItemObj.index]

    it 'Should be sure that the random item is equal to a item from $scope.noDuplicateItems choosen by a randomIndex when NOT allows duplicate item', ->

      $scope.randomForm.allowDuplicateItem = no
      $scope.items = [
        {text: 'item1'}
        {text: 'item2'}
        {text: 'item3'}
      ]
      $scope.$digest()

      $scope.updateNoDuplicateItems()
      oldNoDuplicateItems    = angular.copy($scope.noDuplicateItems)

      randomItemObj = $scope.getRandomItemObj()

     
      expect($scope.noDuplicateItems.length).toEqual oldNoDuplicateItems.length - 1
      expect(randomItemObj.item.text).toEqual  oldNoDuplicateItems[randomItemObj.index].text


  describe 'Method: $scope.addRandomItem', ->
    it 'Should add items', ->
      validItems = [
        { items: ['item1', 'item2'], text: 'item1 and item2' }
        { items: ['item3', 'item4'], text: 'item3 and item4' }
        { items: ['item1'], text: 'item1' }
      ]

      $scope.$digest()

      for validItem in validItems
        $scope.addRandomItem(validItem)

      expect($scope.randomItems.length).toEqual 3

    it 'Should NOT add items with wrong pattern', ->
      invalidItems = [
        { items: null, text: '' }
        { text: 'item1'         } 
        { attr: 'X'}
        null
      ]

      $scope.$digest()

      for invalidItem in invalidItems
        $scope.addRandomItem(invalidItem)

      expect($scope.randomItems.length).toEqual 0

  
  describe 'Method: $scope.getRandomItems', ->
    
    beforeEach ->
      $scope.items = [
        {text: 'item1'}
        {text: 'item2'}
        {text: 'item3'}
        {text: 'item4'}
        {text: 'item5'}
        {text: 'item6'}
      ]

    it 'Should get number of the items defined on $scope.randomForm.numberOfItems variable', ->
      $scope.randomForm.numberOfItems = 4
      $scope.$digest()

      randomItems = $scope.getRandomItems()

      expect(randomItems.items.length).toEqual 4

    it 'Should be a not valid run cause all items have been choosen already and not allows duplicate items', ->
      $scope.randomForm.numberOfItems      = 6
      $scope.randomForm.allowDuplicateItem = no

      $scope.$digest()

      $scope.getRandomItems()
      $scope.getRandomItems()



      expect($scope.validRun).toBeFalsy() 

  describe '$scope.getAllGroupedByNItems', ->
    beforeEach ->
      $scope.items = [
        {text: 'item1'}
        {text: 'item2'}
        {text: 'item3'}
        {text: 'item4'}
        {text: 'item5'}
        {text: 'item6'}
        {text: 'item7'}
      ]

    it 'Should get all items grouped by floor of $scope.random.numberOfItems when allows duplicate items', ->
      $scope.randomForm.numberOfItems      = 4
      $scope.randomForm.allowDuplicateItem = yes

      groups = $scope.getAllGroupedByNItems()

      expect(groups.length).toEqual 1
      expect(groups[0].items.length).toEqual 4

    it 'Should get all items grouped by floor of $scope.random.numberOfItems when NOT allows duplicate items', ->
      $scope.randomForm.numberOfItems      = 2
      $scope.randomForm.allowDuplicateItem = no

      groups = $scope.getAllGroupedByNItems()

      expect(groups.length).toEqual 3
      for group in groups then expect(group.items.length).toEqual 2




      
    

      
      
    
      
    

      

    


      
    

    

      
    


