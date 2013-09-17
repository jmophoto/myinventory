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
    
  $scope.addRoom = ->
    room = Room.save({inspection_id: $scope.inspection_id, name: $scope.newRoom.name, room_type: $scope.newRoom.type})
    $scope.rooms.push(room)
    $scope.newRoom = {}
  
  $scope.deleteRoom = (room, index) ->
    confirmVariable = confirm('Are You Sure?')
    if confirmVariable == true
      room.$delete()
      $scope.rooms.splice(index, 1)
]
  
@FeatureController = ["$scope", "Feature", ($scope, Feature) ->

  $scope.isDirty = (feature) ->
    if feature.clean == false
      feature.clean = null
    else
      feature.clean = false
    Feature.update(feature)
    
  $scope.hasMarks = (feature) ->
    if feature.marks == true
      feature.marks = false
    else
      feature.marks = true
    Feature.update(feature)
    
  $scope.hasDamage = (feature) ->
    if feature.damage == true
      feature.damage = false
    else
      feature.damage = true
    Feature.update(feature)
    
  $scope.addComment = (feature, comment) ->
    feature.comment = comment
    Feature.update(feature)
    
  $scope.deleteFeature = (feature, index) ->
    confirmVariable = confirm('Are you sure?')
    if confirmVariable == true
      Feature.delete(feature)
      $scope.room.inspected_features.splice(index, 1);
]
 