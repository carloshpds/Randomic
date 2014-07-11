'use strict'

angular.module('RandomicApp', ['ui.bootstrap','ui.router', 'ngSanitize'])
  .config( ["$stateProvider", "$urlRouterProvider", ($stateProvider, $urlRouterProvider) => 

    $urlRouterProvider.otherwise('/index-search')

    # States
    # =============================================
    $stateProvider
      
      .state('index-search', 
        url         : '/index-search'
        templateUrl : 'views/index-search.html'
        controller  : 'IndexSearchController'
      )

    
  ])
