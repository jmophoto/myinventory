app = angular.module("Inspeckd", ["ngResource", "ng-rails-csrf", "ngUpload"])

$(document).on('ready page:load', ->
  angular.bootstrap(document, ['Inspeckd'])
)

app.factory "Inspection", ["$resource", ($resource) -> 
  $resource("/inspections/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Room", ["$resource", ($resource) -> 
  $resource("/inspections/:inspection_id/inspected_rooms/:id", {inspection_id: "@inspection_id", id: "@id"}, {update: {method: "PUT"}})
]
  
app.factory "Feature", ["$resource", ($resource) ->
  $resource("/inspected_rooms/:inspected_room_id/inspected_features/:id", {inspected_room_id: "@inspected_room_id", id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Property", ["$resource", ($resource) ->
  $resource("/properties/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Image", ["$resource", ($resource) ->
  $resource("/images/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.directive "fileupload", ->
  restrict: "EA"
  template: "<form action='/images' ng-upload upload-options-enable-rails-csrf><input type='file' name='image[asset]' /><input type='submit' value='Upload' upload-submit='results(content, completed, room)'></input></form>"

@InspectionController = ["$scope", "Room", "Inspection", "Image", ($scope, Room, Inspection, Image) ->
  $scope.inspection = Inspection.get({id: $scope.inspection_id})
    
  $scope.addRoom = ->
    room = Room.save({inspection_id: $scope.inspection_id, name: $scope.newRoom.name, room_type: $scope.newRoom.type})
    $scope.inspection.inspected_rooms.push(room)
    $scope.newRoom = {}
  
  $scope.deleteRoom = (room, index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Room.delete(room)
      $scope.inspection.inspected_rooms.splice(index, 1)
      
  $scope.editRoom = (room) ->
    Room.update(room)
    
  $scope.addImage = (room) ->
    image = Image.save({imageable_id: room.id, imageable_type: "InspectedRoom"})
    $scope.newImage = {}

  $scope.deleteImage = (room_index, image, index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Image.delete(image)
      $scope.inspection.inspected_rooms[room_index].images.splice(index, 1)

  $scope.results = (content, completed, index) ->
    if (completed)
      $scope.uploading = false
      $scope.inspection.inspected_rooms[index].images.push(content)
    else
      $scope.uploading = true
      $scope.response = "Uploading..."
  
]
  

@FeatureController = ["$scope", "Feature", ($scope, Feature) ->
  $scope.isClean = (feature) ->
    if feature.clean == true
      feature.clean = null
    else
      feature.clean = true
    Feature.update(feature)
  
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
    
  $scope.editFeature = (feature) ->
    Feature.update(feature)
    
  $scope.setCondition = (feature, condition) ->
    feature.condition = condition
    Feature.update(feature)
    
  $scope.addFeature = (room) ->
    feature = Feature.save({inspected_room_id: room.id, name: $scope.newFeature.name})
    $scope.room.inspected_features.push(feature)
    $scope.newFeature = {}
    
  $scope.deleteFeature = (feature, index) ->
    confirmVariable = confirm('Are you sure?')
    if confirmVariable == true
      Feature.delete(feature)
      $scope.room.inspected_features.splice(index, 1);
      
]

@PropertyController = ["$scope", "Property", ($scope, Property) ->
  $scope.properties = Property.query()
]

@ImageController = ["$scope", "Image", ($scope, Image) ->
  $scope.images = Image.query()
  
  $scope.addImage = ->
    image = Image.save({inspection_id: 1, asset: $scope.newImage.asset})
    $scope.images.push(image)
    $scope.newImage = {}
]