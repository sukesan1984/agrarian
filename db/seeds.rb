# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

towns = Town.first_or_create([
  {id:1, name: "始まりの街"},
  {id:2, name: "ジット"},
  {id:3, name: "エンモルド" },
  {id:4, name: "ゴルバン" },
  {id:5, name: "シュメット" },
  {id:6, name: "ニムス" },
  {id:7, name: "エジーク" },
])

# テレス山
# 森ヌージュ

areas = Area.first_or_create([
  { id: 10001, area_type: 1, type_id: 1 }, # 始まりの街
  { id: 10002, area_type: 1, type_id: 2 }, # 次の街
  { id: 20001, area_type: 2, type_id: 1 }  # 始まりの街と次の街をつなぐ街道
])

roads = Road.first_or_create([
  { id: 1, name: "古くからある道", road_length: 5 },
  { id: 2, name: "ドラゴノーム", road_length: 10 }
])

routes = Route.first_or_create([
  { id: 1, area_id: 10001, connected_area_id: 20001 },
  { id: 2, area_id: 20001, connected_area_id: 10001 },
  { id: 3, area_id: 20001, connected_area_id: 10002 },
  { id: 4, area_id: 10002, connected_area_id: 20001 }
])
