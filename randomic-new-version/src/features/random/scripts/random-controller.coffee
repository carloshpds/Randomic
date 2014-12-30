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
      $scope.items    = []
      $scope.newItem  = null

      # =============================================
      # Methods
      # =============================================
      $scope.addNewItem = ->
        unless _.isEmpty($scope.newItem)
          $scope.items.push $scope.newItem
          $scope.newItem  = null

      $scope.deleteItemByIndex = ($index) ->
        $scope.items.splice $index, 1

      # =============================================
      # Initialize
      # =============================================
      
       
      # =============================================
      # Return Instance
      # =============================================
      return @

  ]