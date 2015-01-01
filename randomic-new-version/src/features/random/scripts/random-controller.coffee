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
      $scope.getNow = ->
        now = if $window.Date.now then $window.Date.now() else new $window.Date().getTime()
        return now

      $scope.calcRandomCycleNumber = (timestampStringArray)->
        timestampStringArray or= $scope.getNow()
        calcRandomCycleNumber  = 0

        for timestampNumber in timestampStringArray
          timestampNumber       = parseInt timestampNumber, 10
          calcRandomCycleNumber += timestampNumber

        return calcRandomCycleNumber


      $scope.getRandomItem = (randomCycleNumber, timestampFunction) ->
        randomCycleNumber or= $scope.calcRandomCycleNumber()
        timestampFunction or= $scope.getNow
        randomItem        = null
        i                 = 0
        j                 = 0

        while i < randomCycleNumber
          for currentItem, j in $scope.items

            isDivsibleByIndex = timestampFunction() % j is 0
            if isDivsibleByIndex then randomItem = currentItem

          i++

        $scope.randomItems.push randomItem
        return randomItem

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