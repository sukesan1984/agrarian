# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

towns = Town.first_or_create([
  {id:1, name: "始まりの街"},
  {id:2, name: "次の街"}
])

areas = Area.first_or_create([
  { id: 10001, area_type: 1, type_id: 1 }, # 始まりの街
  { id: 10002, area_type: 1, type_id: 2 }, # 次の街
  { id: 20001, area_type: 2, type_id: 1 }  # 始まりの街と次の街をつなぐ街道
])

roads = Road.first_or_create([
  { id: 1, name: "最初の街道" }
])
