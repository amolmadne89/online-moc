# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(name: 'SuperAdmin')
Role.create(name: 'Admin')
Role.create(name: 'Counter')
Role.create(name: 'Customer')

Branch.create(name: 'MOC College Rode')
Branch.create(name: 'MOC City Mall')

User.create(first_name: 'Hanumnat', last_name: 'Khandagale', email: 'hanumant_nashikroad@moc.com', password: 'pass@hanumnatclgmoc', mobile_number: '9922816000', role_id: 2, branch_id: 1)
User.create(first_name: 'Hanumnat', last_name: 'Khandagale', email: 'hanumant_mall@moc.com', password: 'pass@hanumnatmallmoc', mobile_number: '9922816000', role_id: 2, branch_id: 2)
User.create(first_name: 'Manoj', last_name: 'Avhad', email: 'manoj_nashikroad@moc.com', password: 'pass@manojclgmoc', mobile_number: '8237419727', role_id: 2, branch_id: 1)
User.create(first_name: 'Manoj', last_name: 'Avhad', email: 'manoj_mall@moc.com', password: 'pass@manojmallmoc', mobile_number: '8237419727', role_id: 2, branch_id: 2)