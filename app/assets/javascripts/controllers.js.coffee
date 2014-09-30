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

app.factory "Agent", ["$resource", ($resource) ->
  $resource("/agents/:status", {status: "@status"}, {update: {mehtod: "PUT"}})
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

app.factory "Valuable", ["$resource", ($resource) ->
  $resource("/inspections/:inspection_id/valuables/:id", {inspection_id: "@inspection_id", id: "@id"}, {update: {method: "PUT"}})
]

@InspectionController = ["$scope", "InspectedRoom", "Inspection", "Image", "Detail", "Valuable", "Address", "Agent", ($scope, InspectedRoom, Inspection, Image, Detail, Valuable, Address, Agent) ->
  $scope.inspections = Inspection.query()
  $scope.inspection = Inspection.get({id: $scope.inspection_id})
  $scope.agents = Agent.query()

  $scope.assignAgent = (inspection,agent) ->
    inspection.agent_id = agent.id
    inspection.status = 'assigned'
    Inspection.update(inspection)
    
  $scope.unassignAgent = (inspection) ->
    inspection.agent_id = null
    inspection.status = 'pending'
    Inspection.update(inspection)
    
  $scope.isAssigned = (inspection) ->
    inspection.agent_id != null and inspection.completed_by == 'agent'
    
  $scope.isUnassigned = (inspection) ->
    inspection.agent_id is null and inspection.completed_by == 'agent'
    
  $scope.checkAssigned = (inspection) ->
    $scope.agentID == inspection.agent_id
  
  $scope.editInspection = (inspection) ->
    Inspection.update(inspection)
    Address.update(inspection.address)
    $scope.inspectionSaved=true
    $scope.editInspectionForm.$setPristine()
    
  $scope.addValuable = (inspection) ->
    valuable = Valuable.save({inspection_id: inspection.id,name:"New Valuable"})
    $scope.inspection.valuables.push(valuable)
    
  $scope.deleteValuable = (valuable,index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Valuable.delete(valuable)
      $scope.inspection.valuables.splice(index,1)
      
  $scope.editValuable = (valuable) ->
    Valuable.update(valuable)

  $scope.addRoom = ->
    room = InspectedRoom.save({inspection_id: $scope.inspection_id, name: $scope.newRoom.name, room_type: $scope.newRoom.type})
    $scope.inspection.inspected_rooms.push(room)
    $scope.newRoom = {}

  $scope.deleteRoom = (room,index) ->
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
      
  $scope.deleteValuableImage = (valuable_index, image, index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Image.delete(image)
      $scope.inspection.valuables[valuable_index].images.splice(index, 1)

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
                      {name:'Exterior',type:'exterior'},
                      {name:'Storage Unit',type:'storage_unit'}]
  $scope.propertyDetailList ||= []
  $scope.propertyAreaList ||= []
  $scope.countryList = ['USA','Canada']
  $scope.newFeature = {}
  
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
    
  $scope.addFeature = (index) ->
    if $scope.property.rooms[index].features is null
      $scope.property.rooms[index].features = [$scope.newFeature.name]
    else
      $scope.property.rooms[index].features.push($scope.newFeature.name)
    Room.update($scope.property.rooms[index])
    $scope.newFeature = {}
    
  $scope.deleteFeature = (feature,index,room_index) ->
    $scope.property.rooms[room_index].features.splice(index,1)
    Room.update($scope.property.rooms[room_index])
    
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
      $scope.inspection.inspected_rooms[room_index].inspected_features.splice(index, 1)

  $scope.addMiscFeature = (room_index, room) ->
    feature = Feature.save({inspected_room_id: room.id, name: $scope.newFeature.name})
    $scope.inspection.misc_valuables[room_index].inspected_features.push(feature)
    $scope.newFeature = {}
  
  $scope.deleteMiscFeature = (room_index, feature, index) ->
    confirmVariable = confirm("Are you sure?")
    if confirmVariable == true
      Feature.delete(feature)
      $scope.inspection.misc_valuables[room_index].inspected_features.splice(index, 1);


    
]

@MessageController = ["$scope", "Message", ($scope, Message) ->
  $scope.messageSent = false

  $scope.sendMessage = ->
    message = Message.save({name: $scope.newMessage.name, email: $scope.newMessage.email, content: $scope.newMessage.content})
    $scope.newMessage = {}
    $scope.messageSent = true

]

@UserController = ["$scope", "$timeout", "User", "Agent", "Company", "Address", ($scope, $timeout, User, Agent, Company, Address) ->
  $scope.user = User.get({id: $scope.userId})
  $scope.users = User.query()
  $scope.agents = Agent.query()
  $scope.pending_agents = Agent.query({status:"pending"})
  $scope.messages = {}
  
  $scope.editUser = (user) ->
    User.update(user)
    Address.update(user.address).success($scope.messages = [key: "success", value:"Your information was saved."])
    $scope.editUserForm.$dirty=false
    
  $scope.changePassword = (user) ->
    if $scope.newPass
        user.password = $scope.newPass
        user.password_confirmation = $scope.newConfirm
        User.update(user).success($scope.messages = [key: "success", value:"Your password was changed."])
  
  $scope.editCompany = (user) ->
    Company.update(user.company)
    Address.update(user.company.address)
    $scope.editCompanyForm.$dirty = false
    
    
  $scope.updateAgentStatus = (user,isAgent,status) ->
    user.agent = isAgent
    user.agent_status = status
    User.update(user)
    $scope.pending_agents = Agent.query({status:"pending"})

    
  $scope.updateAdminStatus = (user,isAdmin) ->
    user.admin = isAdmin
    User.update(user)
    
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
    if $scope.room.images
      $scope.room.images.push(content)
    else
      $scope.room.images = [content]
    
  $scope.uploadInspectionImage = (content) ->
    $scope.uploadStatus = "nofile"
    $scope.files = []
    if $scope.inspection.images
      $scope.inspection.images.push(content)
    else
      $scope.inspection.images = [content]
    
  $scope.uploadValuableImage = (content,index) ->
    $scope.uploadStatus = "nofile"
    $scope.files = []
    if $scope.valuable.images
      $scope.valuable.images.push(content)
    else
      $scope.valuable.images = [content]
    
  $scope.uploadCompanyImage = (content) ->
    $scope.uploadStatus = "nofile"
    $scope.files = []
    $scope.user.company.logo = content
]

app.value "$strapConfig",
  datepicker:
    format: "yyyy-mm-dd"

