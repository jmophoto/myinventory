# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Plan.create([
  { plan_id: 'agent',
    description: "Full Service Inventory", 
    price: 495
  },
  { plan_id: 'self',
    description: "Do It Yourself Option", 
    price: 250
  }
])
