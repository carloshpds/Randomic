
# =============================================
# Module
# =============================================
angular.module 'RandomicApp'
  .run ['$rootScope', ($rootScope) ->

    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->

      $rootScope.sidenavHidden = toState.data?.sidenavHidden

      $rootScope.state =
        state  : toState
        params : toParams

      $rootScope.lastState =
        state  : fromState
        params : fromParams


    $rootScope.$on '$stateChangeError' , (event, toState, toParams, fromState, fromParams, error) ->
      console.log '[$stateChangeError] error:', error
      console.log '[$stateChangeError] event:', event
      console.log '[$stateChangeError] fromState, fromParams:', fromState, fromParams
      console.log '[$stateChangeError] toState, toParams:', toState, toParams


    $rootScope.$on '$stateChangeStart' , (event, toState, toParams, fromState, fromParams, error) ->
      console.log '[$stateChangeStart] event:', event
      console.log '[$stateChangeStart] fromState, fromParams:', fromState, fromParams
      console.log '[$stateChangeStart] toState, toParams:', toState, toParams

    $rootScope.$on '$stateChangeSuccess' , (event, toState, toParams, fromState, fromParams, error) ->
      console.log '[$stateChangeSuccess] event:', event
      console.log '[$stateChangeSuccess] fromState, fromParams:', fromState, fromParams
      console.log '[$stateChangeSuccess] toState, toParams:', toState, toParams
  ]

