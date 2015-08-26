# this file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

test_email = 'test@test.com'
unless User.find_by(email: test_email)
  user = User.create(email: test_email, password: 'testtest')
  puts 'created test user'

  Player.create(name: 'テスト用', user_id: user.id)
  puts 'created test player'
end

csv_files = Dir.entries("./master").select{|f| f=~ /\.csv$/ }
csv_files.each do |csv_file|
  p "#{csv_file} import..."
  model_name = File.basename(csv_file, ".csv")
  model = model_name.classify.constantize

  path  = "./master/#{csv_file}"
  csv = CSV.read(path, {:headers => true,:encoding => "UTF-8"})
  ActiveRecord::Base.transaction do 
    csv.each do |row|
      if row.has_key?('id')
        record = model.where(id: row['id']).first
        if record.present?
          record.update(row.to_hash)
          next
        end
      end

      model.create(row.to_hash)
    end
  end
end


