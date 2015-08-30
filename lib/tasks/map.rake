require './lib/tasks/map_images.rb'
namespace :map do
  task generate: :environment do
    MapImage.execute
  end
end
