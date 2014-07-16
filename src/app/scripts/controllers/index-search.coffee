'use strict'

angular.module('RandomicApp')
  
  # ====================================================
  # Controller
  # ====================================================
  .controller 'IndexSearchController',  ($scope) =>
    @playerList = [
      'Daniel Mathias'
      'Carlos Nana'
      'Lucas Martins'
      'Bruno Faxina'
      'Tiago Lex'
      'Danilo Arena'
      'Gabriel Stifler'
      'Everton Toninho'
      'Thiago Veiga'
      'Rafael Martinelli'
      'Juliano Pontes'
      'Ricardo Onuma'
      'André Gomes'
      'Thiago Brito'
      'Cassio Mendes'
      'Bruno Oliveira'
      'Rafael Bit'
      'Brunão Nunes'
      'Samir Varandas'
      'Murilo Alencar'
      'Rogério Martinelli'
      'Danilo Kadota'
      'Felipe CLT'
      'Marcelo Felix'
    ] 

    @teamList = [
      'Arsenal'
      'Liverpool'
      'Atlético de Madri'
      'Inter de Milão'
      'Milan'
      'Galatasaray'
      'Schalke 04'
      'Wolfsburg'
      'Zenit'
      'Valencia'
    ]
    

    # ====================================================
    # Attributes
    # ====================================================
    @setAttributesToDefaultValue = =>
      $scope.viewMode   = 'matchMode' 
      $scope.showLoader = no
      $scope.players    = angular.copy @playerList
      $scope.groups     = []

      $scope.teams      = angular.copy @teamList
      $scope.match      = []


      $scope.messenger =
        show        : no
        messageType : 'info'
        message     : 'information'
        prefix      : ''
        sufix       : ''

    
    # ====================================================
    # Watchers
    # ====================================================     

    # ====================================================
    # Handlers
    # ====================================================
    $scope.doSearchHandler = ($event) =>
      do $event.preventDefault

     

    # ====================================================
    # Additional Methods
    # ====================================================
    @initialize = =>
      do @setAttributesToDefaultValue

    $scope.deletePlayers = ->
      $scope.players = []

    $scope.createGroups = () ->
      while $scope.players.length > 0 then do $scope.createGroup

    $scope.createGroup  = ->
      playersAtGroup     = [] 
      i = 0

      while i < 4
        currentPlayerIndex = _.random 0, ($scope.players.length - 1)
        currentPlayer      = $scope.players.splice currentPlayerIndex, 1
        playersAtGroup.push currentPlayer
        i++

      $scope.groups.push players: playersAtGroup

    $scope.resetGroups = =>
      $scope.groups  = []
      $scope.players = angular.copy @playerList


    $scope.selectTeamsToMatch = ->
      $scope.match = []
      teams        = angular.copy $scope.teams
      i            = 0
      while i < 2
        teamIndex    = _.random 0, (teams.length - 1)
        team         = teams.splice teamIndex, 1
        $scope.match.push team 
        i++

    $scope.setViewMode = (mode) ->
      $scope.viewMode = mode


    # ====================================================
    # Aux Methods
    # ====================================================



    # ====================================================
    # Initializers
    # ====================================================
    do @initialize
