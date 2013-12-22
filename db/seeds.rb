# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Plan.create([
  { plan_id: '10',
    description: "$10/month for 5 inspections", 
    price: 10, 
    inspections_per_month: 5},
  { plan_id: '19',
    description: "$19/month for 10 inspections", 
    price: 19, 
    inspections_per_month: 10},
  { plan_id: '35',
    description: "$35/month for 20 inspections", 
    price: 35, 
    inspections_per_month: 20},
  { plan_id: '50',
    description: "$50/month for 50 inspections", 
    price: 50, 
    inspections_per_month: 50},
  { plan_id: '75',
    description: "$75/month for 100 inspections", 
    price: 75, 
    inspections_per_month: 100},
  { plan_id: '99',
    description: "$99/month for unlimited Inspections", 
    price: 99, 
    inspections_per_month: 9999},
])
