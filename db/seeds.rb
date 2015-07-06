# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Town.delete_all
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

Area.delete_all
areas = Area.first_or_create([
  { id: 10001, area_type: 1, type_id: 1 }, # 始まりの街
  { id: 10002, area_type: 1, type_id: 2 }, # 次の街
  { id: 20001, area_type: 2, type_id: 1 }  # 始まりの街と次の街をつなぐ街道
])

Road.delete_all
roads = Road.first_or_create([
  { id: 1, name: "古くからある道", road_length: 5 },
  { id: 2, name: "ドラゴノーム", road_length: 10 }
])

AreaNode.delete_all
area_noads = AreaNode.first_or_create([
  { id: 100011, area_id: 10001, node_point: 1},
  { id: 100021, area_id: 10002, node_point: 1},
  { id: 200011, area_id: 20001, node_point: 1},
  { id: 200012, area_id: 20001, node_point: 2},
  { id: 200013, area_id: 20001, node_point: 3},
  { id: 200014, area_id: 20001, node_point: 4},
  { id: 200015, area_id: 20001, node_point: 5}
])

Route.delete_all
routes = Route.first_or_create([
  { id: 1, area_node_id: 100011, connected_area_node_id: 200011 },
  { id: 2, area_node_id: 200011, connected_area_node_id: 100011 },
  { id: 3, area_node_id: 200015, connected_area_node_id: 100021 },
  { id: 4, area_node_id: 100021, connected_area_node_id: 200015 }
])
