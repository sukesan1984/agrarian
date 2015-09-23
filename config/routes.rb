Rails.application.routes.draw do

  devise_for :users

  mount Agrarian::API => '/api'

  resource 'home' do
    get 'index'
    get 'show'
  end

  root to: 'home#index'

  # player 登録周り
  get  'player/index'
  get  'player/input'
  post 'player/create'
  get  'player/list', to: 'player#list'
  get  'player/ranking_rails', to:'player#ranking_rails'

  # 街のとこ
  resource :towns do
    get  '',          to: 'towns#index'
    get  'not_found', to: 'town#not_found'
    get  ':id',       to: 'town#show'
    post 'write',     to: 'town#write'
  end

  # 街道
  resource :roads do
    get '',          to: 'road#index'
    get 'not_found', to: 'road#not_found'
    get ':id',       to: 'road#show'
  end

  # エリア
  resource :areas do
    get '',          to: 'area#index'
    get 'not_found', to: 'area#not_found'
    get 'cant_move', to: 'area#cant_move'
    get ':id',       to: 'area#show'
  end

  # バトル
  resource :battle do
    get ':area_node_id',        to: 'battle#index'
    get 'escape/:area_node_id', to: 'battle#escape'
  end

  # 宿屋
  resource :inn do
    get  ':id',   to: 'inn#index'
    post 'sleep', to: 'inn#sleep'
  end

  # アイテム
  resource :item do
    get  '',           to: 'item#index'
    post 'use',        to: 'item#use'
    post 'use_actual', to: 'item#use_actual'
    post 'sell',       to: 'item#sell'
    post 'throw',      to: 'item#throw'
    post 'pickup',     to: 'item#pickup'
  end

  # 自然資源
  resource :nature_field do
    get  '',       to: 'nature_field#index'
    post 'action', to: 'nature_field#action'
  end

  # ショップ
  resource :shop do
    get  ':area_node_id/:id', to: 'shop#index'
    post 'buy',               to: 'shop#buy'
  end

  # 装備
  resource :equipment do
    get 'show_detail/:user_item_id', to: 'equipment#show_detail'
    get  ':character_type/:character_id', to: 'equipment#index'
    post 'equip',   to: 'equipment#equip'
    post 'unequip', to: 'equipment#unequip'
  end

  # キャラ
  resource :character do
    get 'status/:character_type/:character_id', to: 'character#status'
  end

  # クエストの奴
  resource :quest do
    get  '',      to: 'quest#index'
    post 'claim', to: 'quest#claim'
  end

  # soldier
  resource :soldier do
    get  '',       to: 'soldier#index'
    post 'remove', to: 'soldier#remove'
    post 'add',    to: 'soldier#add'
  end

  # recipe
  resource :recipe do
    get  '',     to: 'recipe#index'
    post 'make', to: 'recipe#make'
  end

  # skill
  resource :skill do
    get '', to: 'skill#index'
  end

  # bank
  resource :bank do
    get '', to: 'bank#index'
    post 'deposit', to: 'bank#deposit'
    post 'draw', to: 'bank#draw'
  end

  get  'chat', to: 'chat#index'
end
