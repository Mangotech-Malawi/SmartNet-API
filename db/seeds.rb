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
User.destroy_all
Person.destroy_all


User.connection().execute('ALTER TABLE people AUTO_INCREMENT = 1')
User.connection().execute('ALTER TABLE users AUTO_INCREMENT = 1')

Person.create!([{
    firstname: "Asimenye",
    lastname: "Kayuni",
    national_id: "DXCVN3",
    gender: "F"    
}])

Person.all.each do |person|
    ActiveRecord::Base.connection.execute("INSERT INTO users
        (id, username, email,password_digest, role,  person_id, created_at, updated_at)
        VALUES(1, 'asimenye', 'akayuni@gmail.com','$2a$12$eex6Xmx30Xh3/Y68BxGgO.EWmK6WgY7g9vYv/7E7.DU0uXnu8jSA2','admin', #{person.id}, '2022-02-17 09:58:19.098', '2022-06-17 22:56:22.749');
        ")
end

