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
      $scope.items             = []
      $scope.noDuplicateItems  = []
      $scope.randomItems       = []

      $scope.randomForm =
        allowDuplicateItem : no
        numberOfItems      : 1

      $scope.viewUtils =
        showAdvancedOptions : no

      $scope.validRun = yes

      # =============================================
      # Methods
      # =============================================
      $scope.extractOnlyRandomItems = ->
        pluckRandomItems = _.pluck $scope.randomItems, 'items'
        randomItems      = _.flatten pluckRandomItems

        return randomItems

      $scope.updateNoDuplicateItems = ->
        items         = _.pluck angular.copy($scope.items), 'text'
        randomItems   = $scope.extractOnlyRandomItems()

        items                   = _.filter items, (item)-> return not _.contains(randomItems, item)
        $scope.noDuplicateItems = _.map(items, (item)-> return text: item)

      $scope.calcTimestampSum = (timestampStringArray)->
        timestampStringArray or= _.now().toString().split("")
        timestampSum           = 0

        for timestampNumber in timestampStringArray
          timestampNumber  = parseInt timestampNumber, 10
          timestampSum    += timestampNumber

        return timestampSum


      $scope.getRandomIndex = () ->
        randomCycleNumber = $scope.calcTimestampSum()
        max               = if $scope.randomForm.allowDuplicateItem then $scope.items.length - 1 else $scope.noDuplicateItems.length - 1
        i                 = 0

        while i < randomCycleNumber
          randomIndex = _.random(0, max)
          i++

        return randomIndex


      $scope.validateRandomItem = (itemText) ->
        randomItems     = $scope.extractOnlyRandomItems()
        isDuplicateItem = _.contains(randomItems, itemText)
        isValid         = $scope.randomForm.allowDuplicateItem or not isDuplicateItem

        return isValid

      $scope.getRandomItemObj = ->
        randomIndex       = $scope.getRandomIndex()
        randomItem        = if $scope.randomForm.allowDuplicateItem then $scope.items[randomIndex] else $scope.noDuplicateItems[randomIndex]
        randomItemObj     =
          item  : randomItem
          index : randomIndex

        return randomItemObj

      $scope.getRandomItems = (numberOfItems) ->
        $scope.updateNoDuplicateItems()


        numberOfItems    or= $scope.randomForm.numberOfItems
        localRandomItems   = []
        i                  = 0
        $scope.validRun    = $scope.randomForm.allowDuplicateItem or $scope.noDuplicateItems.length > 0

        if $scope.validRun
          while i < numberOfItems
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
      # Events
      # =============================================


      # =============================================
      # Initialize
      # =============================================

       
      # =============================================
      # Return Instance
      # =============================================
      return @

  ]