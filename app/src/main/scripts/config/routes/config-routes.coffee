'use strict'

# =============================================
# Module
# =============================================
angular.module 'RandomicApp'
  
  # =============================================
  # App Config
  # =============================================
  .config( ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->

    # Default State
    # =============================================
    $urlRouterProvider.otherwise('/random')

    
  ])
