app = angular.module("Inspeckd", ["ngResource", "ng-rails-csrf", "ngUpload", "$strap.directives"])

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

app.factory "User", ["$resource", ($resource) ->
  $resource("/users/:id", {id: "@id"}, {update: {method: "PUT"}})
]


