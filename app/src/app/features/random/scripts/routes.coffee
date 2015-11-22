'use strict'

# =============================================
# Module
# =============================================
angular.module 'RandomicApp'

  # =============================================
  # App Config
  # =============================================
  .config( ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->

    # States
    # =============================================
    $stateProvider


      # Login
      # ==============================
      .state('random'
        url         : '/random'
        templateUrl : 'app/features/random/views/random-view.html'
        controller  : 'RandomController'
        data        :
          restrict  : no
      )




  ])
