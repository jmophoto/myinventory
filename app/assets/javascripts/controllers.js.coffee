app = angular.module("Inspeckd", ["ngResource", "ng-rails-csrf", "ngUpload", "$strap.directives"])

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

app.factory "Detail", ["$resource", ($resource) ->
  $resource("/inspection_details/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Message", ["$resource", ($resource) ->
  $resource("/messages/:id", {id: "@id"}, {update: {methid: "PUT"}})
]

app.factory "User", ["$resource", ($resource) -> 
  $resource("/users/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Account", ["$resource", ($resource) ->
  $resource("/users/:user_id/accounts/:id", {user_id: "@user_id", id: "@id"}, {update: {method: "PUT"}})
]

@InspectionController = ["$scope", "Room", "Inspection", "Image", "Detail", ($scope, Room, Inspection, Image, Detail) ->
  $scope.inspection = Inspection.get({id: $scope.inspection_id})
  $scope.inspection_editing = true
  
  $scope.editInspection = (inspection) ->
    Inspection.update(inspection)
  
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
  
  $scope.deleteRoomImage = (room_index, image, index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Image.delete(image)
      $scope.inspection.inspected_rooms[room_index].images.splice(index, 1)
  
  $scope.deleteInspectionImage = (image, index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Image.delete(image)
      $scope.inspection.images.splice(index, 1)
  
  $scope.addRoomImageResults = (content, completed, index) ->
    if (completed)
      $scope.uploading = false
      $scope.inspection.inspected_rooms[index].images.push(content)
    else
      $scope.uploading = true
      $scope.response = "Uploading..." 
  
  $scope.addInspectionImageResults = (content, completed) ->
    if (completed)
      $scope.uploading = false
      $scope.inspection.images.push(content)
    else
      $scope.uploading = true
      $scope.response = "Uploading..." 
  
  $scope.addImageComment = (image, comment) ->
    image.comment = comment
    Image.update(image)
  
  $scope.setDetailStatus = (detail, status) ->
    if detail.status == status
      detail.status = null
    else
      detail.status = status
    Detail.update(detail)
  
  $scope.addDetailComment = (detail, comment) ->
    detail.comment = comment
    Detail.update(detail)
  
  $scope.addDetail = ->
    new_detail = Detail.save({inspection_id: $scope.inspection_id, name: $scope.newDetail.name})
    $scope.inspection.inspection_details.push(new_detail)
    $scope.newDetail = {}
  
  $scope.editDetail = (detail) ->
    Detail.update(detail)
  
  $scope.deleteDetail = (detail, index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Detail.delete(detail)
      $scope.inspection.inspection_details.splice(index, 1)
  
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
    
  $scope.addFeature = (room_index, room) ->
    feature = Feature.save({inspected_room_id: room.id, name: $scope.newFeature.name})
    $scope.inspection.inspected_rooms[room_index].inspected_features.push(feature)
    $scope.newFeature = {}
    
  $scope.deleteFeature = (room_index, feature, index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Feature.delete(feature)
      $scope.inspection.inspected_rooms[room_index].inspected_features.splice(index, 1);
      
]

@MessageController = ["$scope", "Message", ($scope, Message) ->
  $scope.messageSent = false
  
  $scope.sendMessage = ->
    message = Message.save({name: $scope.newMessage.name, email: $scope.newMessage.email, content: $scope.newMessage.content})
    $scope.newMessage = {}
    $scope.messageSent = true
  
]

@UserController = ["$scope", "User", "Account", ($scope, User, Account) ->
  $scope.user = User.get({id: $scope.userId})
  
  $scope.editUser = (user) ->
    User.update(user)
    Account.update(user.account)
  
]

@AccountController = ["$scope", "User", "Account", "Image", ($scope, User, Account, Image) ->
  $scope.account = Account.get({user_id: $scope.userId, id: $scope.accountId})
  
  $scope.addLogoResults = (content, completed) ->
    if (completed)
      $scope.uploading = false
      $scope.account.logo = content
    else
      $scope.uploading = true
      $scope.response = "Uploading..."
      
  $scope.deleteLogo = (image) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Image.delete(image)
      $scope.account.logo = null
]

app.value "$strapConfig",
  datepicker:
    format: "yyyy-mm-dd"

