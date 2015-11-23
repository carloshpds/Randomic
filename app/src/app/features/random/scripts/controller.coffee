'use strict'

# =============================================
# Module
# =============================================
angular.module 'RandomicApp.controllers'

  # =============================================
  # RandomController
  # =============================================
  .controller 'RandomController', ($scope, $filter, $window, randomicStorageKeys, $timeout) ->

    # =============================================
    # Attributes
    # =============================================
    $scope.randomicStorage   = simpleStorage.get(randomicStorageKeys.INFO_KEY)
    $scope.items             = []
    $scope.noDuplicateItems  = []
    $scope.randomItems       = []

    $scope.randomForm =
      allowDuplicateItem : no
      numberOfItems      : 1
      remember           : yes

    $scope.viewUtils =
      showAdvancedOptions : no
      introOptions        :
        exitOnOverlayClick  : no
        showStepNumbers     : no
        disableInteraction  : yes
        doneLabel           : 'Ok'
        steps: [
          { element: '.randomic-logo', intro: "Welcome to Randomic, a friendly user interface to extract random items from a simple list." }
          { element: '#items-input', intro: "You can add items here to start" }
        ]

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

      if $scope.randomForm.allowDuplicateItem
        randomItem  =  $scope.items[randomIndex]
      else
        randomItem  =  $scope.noDuplicateItems[randomIndex]
        $scope.noDuplicateItems.splice randomIndex, 1

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

      if not $scope.randomForm.allowDuplicateItem  and numberOfItems > $scope.noDuplicateItems.length then numberOfItems = $scope.noDuplicateItems.length


      if $scope.validRun
        while i < numberOfItems
          randomItem = $scope.getRandomItemObj().item
          localRandomItems.push randomItem.text
          i++

        localRandomItems =
          items : localRandomItems
          text  : _.toSentence(localRandomItems, ', ', ' and ')

        $scope.addRandomItem localRandomItems
        $scope.saveInfoInStorage()

      return localRandomItems

    $scope.getAllGroupedByNItems = ->
      $scope.updateNoDuplicateItems()
      numberOfGroups = 0
      i              = 0
      groups         = []

      if $scope.randomForm.allowDuplicateItem
        numberOfGroups = $window.Math.floor( $scope.items.length / $scope.randomForm.numberOfItems )
      else
        numberOfGroups = $window.Math.floor( $scope.noDuplicateItems.length / $scope.randomForm.numberOfItems )

      while i < numberOfGroups
        groups.push $scope.getRandomItems()
        i++

      return groups


    $scope.addRandomItem = (item) ->
      if item?.items and item.text
        $scope.randomItems.push item
        $scope.saveInfoInStorage()
      else
        no

    $scope.resetRandomItems = ->
      $scope.randomItems = []
      $scope.saveInfoInStorage()

    $scope.saveInfoInStorage = () ->
      simpleStorage.set randomicStorageKeys.INFO_KEY,
        items              : $scope.items
        noDuplicateItems   : $scope.noDuplicateItems
        randomItems        : $scope.randomItems
        randomForm         : $scope.randomForm
        validRun           : $scope.validRun

    $scope.restoreInfoFromStorage = ->
      $scope.randomicStorage   = simpleStorage.get(randomicStorageKeys.INFO_KEY)

      if $scope.randomicStorage
        $scope.items            = $scope.randomicStorage.items
        $scope.noDuplicateItems = $scope.randomicStorage.noDuplicateItems
        $scope.randomItems      = $scope.randomicStorage.randomItems
        $scope.randomForm       = $scope.randomicStorage.randomForm
        $scope.validRun         = $scope.randomicStorage.validRun

      return $scope.randomicStorage

    $scope.resetStorage = ->
      simpleStorage.deleteKey randomicStorageKeys.INFO_KEY

    # =============================================
    # Events
    # =============================================
    $scope.$watch 'randomForm.remember', (newVal, oldVal) ->
      if newVal is no then $scope.resetStorage()

    # =============================================
    # Initialize
    # =============================================
    $scope.restoreInfoFromStorage()

    $timeout ->
      $scope.startIntro() if $scope.items.length is 0

    # =============================================
    # Return Instance
    # =============================================
    return @