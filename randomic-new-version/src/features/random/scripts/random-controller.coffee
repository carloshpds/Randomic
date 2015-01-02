'use strict'

# =============================================
# Module
# =============================================
angular.module 'RandomicApp.controllers'

  # =============================================
  # RandomController
  # =============================================
  .controller 'RandomController', ['$scope', '$filter', '$window'
    ($scope, $filter, $window) ->

      # =============================================
      # Attributes
      # =============================================
      $scope.items       = []
      $scope.randomItems = []

      $scope.randomForm =
        allowDuplicateItem : no
        numberOfItems      : 1

      # =============================================
      # Methods
      # =============================================
      

      $scope.calcTimestampSum = (timestampStringArray)->
        timestampStringArray or= _.now().toString().split("")
        timestampSum           = 0

        for timestampNumber in timestampStringArray
          timestampNumber  = parseInt timestampNumber, 10
          timestampSum    += timestampNumber

        return timestampSum


      $scope.getRandomIndex = () ->
        randomCycleNumber = $scope.calcTimestampSum()
        i                 = 0

        while i < randomCycleNumber
          randomIndex = _.random(0, $scope.items.length - 1)
          i++

        return randomIndex


      $scope.validateRandomItem = (itemText) ->
        pluckRandomItems = _.pluck $scope.randomItems, 'items'
        randomItems      = _.flatten pluckRandomItems

        isDuplicateItem = _.contains(randomItems, itemText)
        isValid         = $scope.randomForm.allowDuplicateItem or not isDuplicateItem

        return isValid

      $scope.getRandomItemObj = ->
        randomIndex       = $scope.getRandomIndex()
        randomItem        = $scope.items[randomIndex]
        isValidRandomItem = $scope.validateRandomItem(randomItem.text)
        randomItemObj     =
          item  : randomItem
          index : randomIndex

        if isValidRandomItem then randomItemObj else $scope.getRandomItemObj()

      $scope.getRandomItems = ->
        localRandomItems = []
        i = 0

        while i < $scope.randomForm.numberOfItems
          randomItem = $scope.getRandomItemObj().item
          localRandomItems.push randomItem.text
          i++

        localRandomItems = 
          items : localRandomItems
          text  : _.toSentence(localRandomItems, ', ', ' and ')

        $scope.addRandomItem localRandomItems
        return localRandomItems

      $scope.addRandomItem = (item) ->
        if item?.items and item.text then $scope.randomItems.push item else no

      $scope.resetRandomItems = ->
        $scope.randomItems = []

      # =============================================
      # Initialize
      # =============================================

       
      # =============================================
      # Return Instance
      # =============================================
      return @

  ]