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
  {id:4, name: "荒廃した街「ゴルバン」" },
  {id:5, name: "シュメット" },
  {id:6, name: "ニムス" },
  {id:7, name: "エジーク" },
  {id:8, name: "地方都市「アンカーラ」" },
  {id:9, name: "城塞都市「ヘイゲン」" },
  {id:10, name: "王都「ゴーランド」" },
  {id:11, name: "港町「セントレア」" }
])

Establishment.delete_all
establishments = Establishment.first_or_create([
  {id: 1, town_id: 1, establishment_type: 1, establishment_id: 1}
])

Road.delete_all
roads = Road.first_or_create([
  { id: 1, name: "古くからある道", road_length: 5 },
  { id: 2, name: "森へと続く道", road_length: 3 },
  { id: 3, name: "ドラゴノーム", road_length: 10 },
  { id: 4, name: "迷いの道", road_length: 4 }
])

NatureField.delete_all
nature_fields = NatureField.first_or_create([
  { id: 1, name: "近くの森「ヌージュ」", description: "森と呼べるのか果たして怪しいような小さな森。", harvest_id: 1, resource_id: 1 }
])

Dungeon.delete_all
dungeons = Dungeon.first_or_create([
  { id: 1, name: "ゴブリンの洞窟", description: "いつの間にかゴブリンが住み着いてしまった洞窟。ゴブリンは弱いので、地元の子供達の度胸試しに使われてたりする。" }
])

Harvest.delete_all
harvests = Harvest.first_or_create([
  { id: 1, name: "木を切る", description: "その辺りに生えている木を切る行為。やりすぎると自然破壊につながるので注意" }
])

Resource.delete_all
resources = Resource.first_or_create([
  { id: 1, name: "ただの木",             item_id: 100001,  recover_count: 1, recover_interval: 60,   max_count: 100 },
  { id: 2, name: "一般的なお店の木切れ", item_id: 100001, recover_count: 10, recover_interval: 1800, max_count: 100}
])

Shop.delete_all
shops = Shop.first_or_create([
  { id: 1, name: "雑貨屋「スタートアップ」", description: "本当にしょぼいアイテムしか売ってません。" }
])

Showcase.delete_all
showcases = Showcase.first_or_create([
  { id: 1, shop_id: 1, resource_id: 2, cost: 5 }
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
  { id: 20004, area_type: 2, type_id: 4 }, # 森とゴブリンの洞窟をつなぐ街道
  { id: 30001, area_type: 3, type_id: 1 }, # 近くの森 
  { id: 40001, area_type: 4, type_id: 1 }  # ゴブリンの洞窟
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
  { id: 200041, area_id: 20004, node_point: 1},
  { id: 200042, area_id: 20004, node_point: 2},
  { id: 200043, area_id: 20004, node_point: 3},
  { id: 200044, area_id: 20004, node_point: 4},
  { id: 300011, area_id: 30001, node_point: 1},
  { id: 400011, area_id: 40001, node_point: 1}
])

Route.delete_all
routes = Route.first_or_create([
  { id: 1,  area_node_id: 100011, connected_area_node_id: 200011 },
  { id: 2,  area_node_id: 200011, connected_area_node_id: 100011 },
  { id: 3,  area_node_id: 200015, connected_area_node_id: 100021 },
  { id: 4,  area_node_id: 100021, connected_area_node_id: 200015 },
  { id: 5,  area_node_id: 200013, connected_area_node_id: 200021 },
  { id: 6,  area_node_id: 200021, connected_area_node_id: 200013 },
  { id: 7,  area_node_id: 200023, connected_area_node_id: 300011 },
  { id: 8,  area_node_id: 300011, connected_area_node_id: 200023 },
  { id: 9,  area_node_id: 300011, connected_area_node_id: 200041 },
  { id: 10,  area_node_id: 200041, connected_area_node_id: 300011 },
  { id: 11,  area_node_id: 200044, connected_area_node_id: 400011 },
  { id: 12, area_node_id: 400011, connected_area_node_id: 200044 }
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
