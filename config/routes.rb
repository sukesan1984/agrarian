Rails.application.routes.draw do

  devise_for :users
  get 'home/index'

  get 'home/show'

  # player 登録周り
  get 'player/index'
  get 'player/input'
  post 'player/create'
  get 'player/list', to: 'player#list'
  get 'player/ranking_rails', to:'player#ranking_rails'

  root to: "home#index"

  # 街のとこ
  get 'towns/', to: 'towns#index'
  get 'towns/not_found', to: 'town#not_found'
  get 'towns/:id', to: 'town#show'
  post 'towns/write', to: 'town#write'

  # 街道
  get 'roads/', to: 'road#index'
  get 'roads/not_found', to: 'road#not_found'
  get 'roads/:id', to: 'road#show'

  # 場所のとこ
  get 'areas/', to: 'area#index'
  get 'areas/not_found', to: 'area#not_found'
  get 'areas/:id', to: 'area#show'

  # バトル
  get 'battle/:area_id', to: 'battle#index'

  #宿屋
  get 'inn/:id', to: 'inn#index'
  post 'inn/sleep', to: 'inn#sleep'

  #アイテム
  get 'item/', to: 'item#index'
  post 'item/use', to: 'item#use' 
  post 'item/use_actual', to: 'item#use_actual'
  post 'item/sell', to: 'item#sell'

  #自然の奴
  get 'nature_field/', to: 'nature_field#index'
  post 'nature_field/action', to: 'nature_field#action'

  get 'shop/:area_node_id/:id', to: 'shop#index'
  post 'shop/buy', to: 'shop#buy'

  # 装備やつ
  get 'equipment', to: 'equipment#index'
  post 'equipment/equip', to: 'equipment#equip'
  post 'equipment/unequip', to: 'equipment#unequip'

  # クエストの奴
  get 'quest', to: 'quest#index'
  post 'quest/claim', to: 'quest#claim' 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
