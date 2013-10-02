module ApplicationHelper
  
  def full_list
    room_name = []
    ROOM_FEATURES.each do |room|
      room_name << room[0]
    end
    room_name
  end
  
  def room_list
    room_name = []
    ROOM_FEATURES.each do |room|
      room_name << room[0] if room[1]['is_room']
    end
    room_name
  end
  
  def area_list
    room_name = []
    ROOM_FEATURES.each do |room|
      room_name << room[0] unless room[1]['is_room']
    end
    room_name
  end
  
  def detail_list
    ['CO detector', 'Smoke detector', 'Keys', 'Water shutoff', 'Fire extinguisher']
  end
  
  def inspection_types 
    ['Move-In', 'Move-Out', 'Periodical', 'Drive-By', 'Other']
  end
  
  def states
    [ "Alaska", 
      "Alabama", 
      "Arkansas", 
      "American Samoa", 
      "Arizona", 
      "California", 
      "Colorado", 
      "Connecticut", 
      "District of Columbia", 
      "Delaware", 
      "Florida", 
      "Georgia", 
      "Guam", 
      "Hawaii", 
      "Iowa", 
      "Idaho", 
      "Illinois", 
      "Indiana", 
      "Kansas", 
      "Kentucky", 
      "Louisiana", 
      "Massachusetts", 
      "Maryland", 
      "Maine", 
      "Michigan", 
      "Minnesota", 
      "Missouri", 
      "Mississippi", 
      "Montana", 
      "North Carolina", 
      "North Dakota", 
      "Nebraska", 
      "New Hampshire", 
      "New Jersey", 
      "New Mexico", 
      "Nevada", 
      "New York", 
      "Ohio", 
      "Oklahoma", 
      "Oregon", 
      "Pennsylvania", 
      "Puerto Rico", 
      "Rhode Island", 
      "South Carolina", 
      "South Dakota", 
      "Tennessee", 
      "Texas", 
      "Utah", 
      "Virginia", 
      "Virgin Islands", 
      "Vermont", 
      "Washington", 
      "Wisconsin", 
      "West Virginia", 
      "Wyoming"]
    end
  
end
