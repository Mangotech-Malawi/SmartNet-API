# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Creating test user"
Person.destroy_all
User.destroy_all

User.connection().execute('ALTER TABLE people AUTO_INCREMENT = 1')
User.connection().execute('ALTER TABLE users AUTO_INCREMENT = 1')

Person.create!([{
    firstname: "Asimenye",
    lastname: "Kayuni",
    national_id: "DXCVN3",
    gender: "F"    
}])

Person.all.each do |person|
    User.create!([{
        username: "asimenye",
        email: "akayuni@gmail.com",
        password: "kayuni12!",
        role: "admin",
        person_id: person.id
    }])
end

