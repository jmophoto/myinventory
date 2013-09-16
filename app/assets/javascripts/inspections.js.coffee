# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("Inspeckd", ["ngResource", "ng-rails-csrf"])

app.factory "Room", ["$resource", ($resource) -> 
  $resource("/inspections/:inspection_id/inspected_rooms/:id", {inspection_id: "@inspection_id", id: "@id"}, {update: {method: "PUT"}})
]
  
app.factory "Feature", ["$resource", ($resource) ->
  $resource("/inspected_rooms/:inspected_room_id/inspected_features/:id", {inspected_room_id: "@inspected_room_id", id: "@id"}, {update: {method: "PUT"}})
]

@InspectionController = ["$scope", "Room", ($scope, Room) ->
  $scope.rooms = Room.query({inspection_id: $scope.inspection_id})  
]
  
@FeatureController = ["$scope", "Feature", ($scope, Feature) ->
  $scope.features = Feature.query({inspected_room_id: $scope.inspected_room_id})
  
  $scope.isClean = (feature) ->
    if feature.clean == true
      feature.clean = null
    else
      feature.clean = true
    feature.$update()
    
  $scope.isDirty = (feature) ->
    if feature.clean == false
      feature.clean = null
    else
      feature.clean = false
    feature.$update()
    
  $scope.hasMarks = (feature) ->
    if feature.marks == true
      feature.marks = false
    else
      feature.marks = true
    feature.$update()
    
  $scope.hasDamage = (feature) ->
    if feature.damage == true
      feature.damage = false
    else
      feature.damage = true
    feature.$update()
    
  $scope.addComment = (feature, comment) ->
    feature.comment = comment
    feature.$update()
]
 