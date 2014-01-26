app = angular.module("Inspeckd", ["ngRoute", "ngResource", "ng-rails-csrf", "ngUpload", "$strap.directives"])

$(document).on('ready page:load', ->
  angular.bootstrap('body', ['Inspeckd'])
)

app.factory "Inspection", ["$resource", ($resource) -> 
  $resource("/inspections/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory "InspectedRoom", ["$resource", ($resource) -> 
  $resource("/inspections/:inspection_id/inspected_rooms/:id", {inspection_id: "@inspection_id", id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Room", ["$resource", ($resource) -> 
  $resource("/properties/:property_id/rooms/:id", {property_id: "@property_id", id: "@id"}, {update: {method: "PUT"}})
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

app.factory "Address", ["$resource", ($resource) -> 
  $resource("/addresses/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Company", ["$resource", ($resource) -> 
  $resource("/companies/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Account", ["$resource", ($resource) ->
  $resource("/users/:user_id/accounts/:id", {user_id: "@user_id", id: "@id"}, {update: {method: "PUT"}})
]

app.factory "PaymentMethod", ["$resource", ($resource) ->
  $resource("/payment_methods/:id", {id: "@id"}, {update: {method: "PUT"}})
]

@InspectionController = ["$scope", "InspectedRoom", "Inspection", "Image", "Detail", ($scope, InspectedRoom, Inspection, Image, Detail) ->
  $scope.inspections = Inspection.query()
  $scope.inspection = Inspection.get({id: $scope.inspection_id})

  $scope.editInspection = (inspection) ->
    Inspection.update(inspection)

  $scope.addRoom = ->
    room = InspectedRoom.save({inspection_id: $scope.inspection_id, name: $scope.newRoom.name, room_type: $scope.newRoom.type})
    $scope.inspection.inspected_rooms.push(room)
    $scope.newRoom = {}

  $scope.deleteRoom = (room, index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      InspectedRoom.delete(room)
      $scope.inspection.inspected_rooms.splice(index, 1)

  $scope.editRoom = (room) ->
    InspectedRoom.update(room)

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

@PropertyController = ["$scope", "Property", "Address", "Room", ($scope, Property, Address, Room) ->
  $scope.properties = Property.query()
  $scope.property = Property.get({id: $scope.propertyId})
  $scope.room_list = [{name:'Bedroom',type:'bedroom'},
                      {name:'Bathroom',type:'bathroom'},
                      {name:'Kitchen',type:'kitchen'},
                      {name:'Dining Room',type:'dining_room'},
                      {name:'Living Room',type:'living_room'},
                      {name:'Family Room',type:'family_room'},
                      {name:'Laundry',type:'laundry'},
                      {name:'Office',type:'office'}]
  $scope.area_list = [{name:'Entry',type:'entry'},
                      {name:'Hallway',type:'hallway'},
                      {name:'Staircase',type:'staircase'},
                      {name:'Garage',type:'garage'},
                      {name:'Exterior',type:'exterior'}]
  $scope.propertyDetailList ||= []
  $scope.propertyAreaList ||= []
  $scope.countryList = ['USA','Canada']
  
  $scope.checkForDetail = (scope,detail) ->
    scope.indexOf(detail) > -1
    
  $scope.checkForArea = (scope,area) ->
    scope.indexOf(area) > -1
    
  $scope.addDetailToProperty = (detail) ->
    if $scope.property.details is null
      $scope.property.details = [detail]
    else
      index = $scope.property.details.indexOf(detail)
      if index == -1
        $scope.property.details.push(detail)
      else
        $scope.property.details.splice(index,1)
      
  $scope.addDetailToList = (detail) ->
    if $scope.propertyDetailList is undefined
      $scope.propertyDetailList = [detail]
    else
      index = $scope.propertyDetailList.indexOf(detail)
      if index == -1
        $scope.propertyDetailList.push(detail)
      else
        $scope.propertyDetailList.splice(index,1)
        
  $scope.addAreaToList = (area) ->
    if $scope.propertyAreaList is undefined
      $scope.propertyAreaList = [area]
    else
      index = $scope.propertyAreaList.indexOf(area)
      if index == -1
        $scope.propertyAreaList.push(area)
      else
        $scope.propertyAreaList.splice(index,1)
       
  $scope.createProperty = ->
    $scope.newProperty.details = $scope.propertyDetailList
    $scope.newProperty.room_count = $scope.room_list
    $scope.newProperty.other_areas = $scope.propertyAreaList
    property = Property.save($scope.newProperty)
    $scope.properties.push(property)
    $("#newPropertyModal").modal('hide')
    $scope.newProperty = {}
    
  $scope.editProperty = (property) ->
    Property.update(property)
    Address.update(property.address)
    $scope.editPropertyForm.$dirty=false
    
  $scope.deleteProperty = (property,index) ->
    confirmVariable = confirm(index)
    if confirmVariable == true
      Property.delete(property)
      $scope.properties.splice(index, 1)

  $scope.addRoom = ->
    room = Room.save({property_id: $scope.propertyId, name: $scope.newRoom.name, room_type: $scope.newRoom.type})
    $scope.property.rooms.push(room)
    $scope.newRoom = {}
    
  $scope.deleteRoom = (room, index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Room.delete(room)
      $scope.property.rooms.splice(index, 1)

  $scope.editRoom = (room) ->
    Room.update(room)
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

@UserController = ["$scope", "User", "Company", "Address", ($scope, User, Company, Address) ->
  $scope.user = User.get({id: $scope.userId})

  $scope.editUser = (user) ->
    User.update(user)
    Address.update(user.address)
    Company.update(user.company)
    Address.update(user.company.address)
    $scope.editUserForm.$dirty=false 
  
  $scope.editCompany = (user) ->
    Company.update(user.company)
    Address.update(user.company.address)
    $scope.editCompanyForm.$dirty = false

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

@PaymentMethodController = ["$scope", "PaymentMethod", ($scope, PaymentMethod) ->
  $scope.payment_methods = PaymentMethod.query()

  $scope.isExpired = (pm) ->
    new Date() > new Date(pm.expiration_date)

  $scope.deletePaymentMethod = (pm,index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      PaymentMethod.delete(pm)
      $scope.payment_methods.splice(index, 1)

  $scope.makeDefault = (pm) ->
    confirmVariable = confirm("Make this card the default payment method?")
    if confirmVariable == true
      PaymentMethod.update(pm)
      $scope.payment_methods = PaymentMethod.query()

]

@ImageController = ["$scope", "Image", ($scope, Image) ->
  $scope.uploadStatus = "nofile"
    
  $scope.setFiles = (element) ->
    $scope.uploadStatus = "hasfile"
    $scope.$apply ($scope) ->
      $scope.files = []
      i = 0
      while i < element.files.length
        $scope.files.push element.files[i]
        i++
  
  $scope.startUpload = ->
    $scope.uploadStatus = "uploading"
  
  $scope.deleteLogo = (image) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Image.delete(image)
      $scope.user.company.logo = null
  
  $scope.uploadRoomImage = (content) ->
    $scope.uploadStatus = "nofile"
    $scope.files = []
    $scope.room.images.push(content)
    
  $scope.uploadInspectionImage = (content) ->
    $scope.uploadStatus = "nofile"
    $scope.files = []
    $scope.inspection.images.push(content)
    
  $scope.uploadCompanyImage = (content) ->
    $scope.uploadStatus = "nofile"
    $scope.files = []
    $scope.user.company.logo = content
]

app.value "$strapConfig",
  datepicker:
    format: "yyyy-mm-dd"

