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

Road.delete_all
roads = Road.first_or_create([
  { id: 1, name: "古くからある道", road_length: 5 },
  { id: 2, name: "森へと続く道", road_length: 3 },
  { id: 3, name: "ドラゴノーム", road_length: 10 }
])

NatureField.delete_all
nature_fields = NatureField.first_or_create([
  { id: 1, name: "近くの森「ヌージュ」", description: "森と呼べるのか果たして怪しいような小さな森。" }
])

# テレス山
# 森ヌージュ

Area.delete_all
areas = Area.first_or_create([
  { id: 10001, area_type: 1, type_id: 1 }, # 始まりの街
  { id: 10002, area_type: 1, type_id: 2 }, # 次の街
  { id: 10003, area_type: 1, type_id: 3 }, # エンモルド
  { id: 20001, area_type: 2, type_id: 1 }, # 始まりの街と次の街をつなぐ街道
  { id: 20002, area_type: 2, type_id: 2 }, # 始まりの街と近くの森をつなぐ街道
  { id: 30001, area_type: 3, type_id: 1 }  # 近くの森 
])

AreaNode.delete_all
area_noads = AreaNode.first_or_create([
  { id: 100011, area_id: 10001, node_point: 1},
  { id: 100021, area_id: 10002, node_point: 1},
  { id: 100031, area_id: 10003, node_point: 1},
  { id: 200011, area_id: 20001, node_point: 1},
  { id: 200012, area_id: 20001, node_point: 2},
  { id: 200013, area_id: 20001, node_point: 3},
  { id: 200014, area_id: 20001, node_point: 4},
  { id: 200015, area_id: 20001, node_point: 5},
  { id: 200021, area_id: 20002, node_point: 1},
  { id: 200022, area_id: 20002, node_point: 2},
  { id: 200023, area_id: 20002, node_point: 3},
  { id: 300011, area_id: 30001, node_point: 1}
])

Route.delete_all
routes = Route.first_or_create([
  { id: 1, area_node_id: 100011, connected_area_node_id: 200011 },
  { id: 2, area_node_id: 200011, connected_area_node_id: 100011 },
  { id: 3, area_node_id: 200015, connected_area_node_id: 100021 },
  { id: 4, area_node_id: 100021, connected_area_node_id: 200015 },
  { id: 5, area_node_id: 200013, connected_area_node_id: 200021 },
  { id: 6, area_node_id: 200021, connected_area_node_id: 200013 },
  { id: 7, area_node_id: 200023, connected_area_node_id: 300011 },
  { id: 8, area_node_id: 300011, connected_area_node_id: 200023 }
])

Enemy.delete_all
enemies = Enemy.first_or_create([
  { id: 1, name: "ゴブリン", attack: 3, defense: 3, hp: 10},
  { id: 2, name: "野犬",     attack: 1, defense: 1, hp: 5 }
])

Item.delete_all
items = Item.first_or_create([
  { id: 100001, name: "木切れ", description: "木の切れ端。何の木から出たものかはよくわからない。", item_type: 1, item_type_id: 1 }
])
