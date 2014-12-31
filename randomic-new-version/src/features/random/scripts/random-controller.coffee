'use strict'

# =============================================
# Module
# =============================================
angular.module 'RandomicApp.controllers'

  # =============================================
  # RandomController
  # =============================================
  .controller 'RandomController', ['$scope', '$filter',
    ($scope, $filter) ->

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


      # =============================================
      # Initialize
      # =============================================
      $scope.getRandomItem = ->
        $scope.randomItems.push 'Random Item'

      $scope.resetRandomItems = ->
        $scope.randomItems = []
       
      # =============================================
      # Return Instance
      # =============================================
      return @

  ]