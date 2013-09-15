# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("Inspeckd", ["ngResource"])

@InspectionController = ($scope, $resource) ->
  Room = $resource("/inspections/:inspection_id/inspected_rooms/:id", {inspection_id: "@inspection_id", id: "@id"}, {update: {method: "PUT"}})
  $scope.rooms = Room.query({inspection_id: $scope.inspection_id})  
  
@FeatureController = ($scope, $resource) ->
  Feature = $resource("/inspections/17/inspected_rooms/:inspected_room_id/inspected_features/:id", {inspected_room_id: "@inspected_room_id", id: "@id"}, {update: {method: "PUT"}})
  $scope.features = Feature.query({inspected_room_id: $scope.inspected_room_id})
  
  $scope.isClean = (feature) ->
    alert(feature.name)
    feature.clean = true
    feature.$update()
 