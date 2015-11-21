'use strict'


# =============================================
# Modules
# =============================================
angular.module 'RandomicApp.controllers' , []
angular.module 'RandomicApp.filters'     , []
angular.module 'RandomicApp.factories'   , []
angular.module 'RandomicApp.services'    , []
angular.module 'RandomicApp.constants'   , []
angular.module 'RandomicApp.directives'  , []


# =============================================
# Scripts Module
# =============================================
angular.module 'RandomicApp.scripts'     , [
  'RandomicApp.controllers'
  'RandomicApp.constants'
  'RandomicApp.filters'
  'RandomicApp.factories'
  'RandomicApp.services'
  'RandomicApp.directives'
]


# =============================================
# Main Module
# =============================================
angular.module('RandomicApp', [
  'ngSanitize'
  'QuickList'
  'ui.router'
  'ui.bootstrap'
  'RandomicApp.scripts'
  'ngTagsInput'
])


  # =============================================
  # Initialize
  # =============================================
  .run ($window) ->

    # Import underscore-string into underscore
    # =================================
    _.mixin($window.s.exports())

    # Change Moment relative time
    moment.lang 'pt-br',
      relativeTime :
        future: "em %s"
        past:   "%s atrás"
        s:  "segundos"
        m:  "um minuto"
        mm: "%d minutos"
        h:  "uma hora"
        hh: "%d horas"
        d:  "um dia"
        dd: "%d dias"
        M:  "um mês"
        MM: "%d meses"
        y:  "um ano"
        yy: "%d anos"

    moment.lang('pt-br')


  # =============================================
  # httpProvider Config
  # =============================================
  .config( ['$httpProvider', ($httpProvider) ->

    # Customize $httpProvider
    # =============================================
    # $httpProvider.defaults.transformRequest  = (data) -> if data then $.param(data) else data
    # $httpProvider.defaults.headers.post      = "Content-Type": 'application/json'
  ])





