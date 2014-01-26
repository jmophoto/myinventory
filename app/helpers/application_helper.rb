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
    ['CO Detector', 'Smoke Detector', 'Keys', 'Water Shutoff', 'Fire Extinguisher']
  end
  
  def inspection_types 
    ['Move-In', 'Move-Out', 'Periodical', 'Drive-By', 'Other']
  end
  
  def month_select
    [
      ['1 - January', '01'], 
      ['2 - February', '02'], 
      ['3 - March', '03'], 
      ['4 - April', '04'], 
      ['5 - May', '05'],
      ['6 - June', '06'],
      ['7 - July', '07'],
      ['8 - August', '08'],
      ['9 - September', '09'],
      ['10 - October', '10'],
      ['11 - November', '11'],
      ['12 - December', '12'],
    ]
  end
  
  def year_select
    (Date.today.year..(Date.today+10.years).year).to_a    
  end
  
  def state_abbreviations
    [ "AK",
      "AL", 
      "AR", 
      "AS", 
      "AZ", 
      "CA", 
      "CO", 
      "CT", 
      "DC", 
      "DE", 
      "FL", 
      "GA", 
      "GU", 
      "HI", 
      "IA", 
      "ID", 
      "IL", 
      "IN", 
      "KS", 
      "KY", 
      "LA", 
      "MA", 
      "MD", 
      "ME", 
      "MI", 
      "MN", 
      "MO", 
      "MS", 
      "MT", 
      "NC", 
      "ND", 
      "NE", 
      "NH", 
      "NJ", 
      "NM", 
      "NV", 
      "NY", 
      "OH", 
      "OK", 
      "OR", 
      "PA", 
      "PR", 
      "RI", 
      "SC", 
      "SD", 
      "TN", 
      "TX", 
      "UT", 
      "VA", 
      "VI", 
      "VT", 
      "WA", 
      "WI", 
      "WV", 
      "WY",
      "--",
      "AB",
      "BC", 
      "MB", 
      "NB", 
      "NL", 
      "NT", 
      "NS", 
      "NU", 
      "ON", 
      "PE", 
      "QC", 
      "SK", 
      "YT"
    ]
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
    
    def provinces
      ["British Columbia", 
      "Ontario", 
      "Newfoundland/Labrador", 
      "Nova Scotia", 
      "Prince Edward Island", 
      "New Brunswick", 
      "Quebec", 
      "Manitoba", 
      "Saskatchewan", 
      "Alberta", 
      "Northwest Territories", 
      "Nunavut",
      "Yukon Territory"]
    end
  
end
