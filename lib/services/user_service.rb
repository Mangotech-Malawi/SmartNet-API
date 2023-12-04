module UserService
    def self.new_user(national_id:, username:, firstname:, lastname:, email:, role:)
      Person.transaction do
        
        person = Person.create!( national_id: national_id, firstname: firstname, lastname: lastname)
        person_id = person.id
        if person
          User.transaction do
            password = generate_random_password

            user = User.create!( person_id: person_id,  username: username, 
                                password: password, email: email, role: role )
            
            { user: user, password: password}
          end
        end
      end
    end

    def self.users
      users = User.joins(:person).distinct.select('users.id, national_id, 
                        username, firstname, lastname, email, gender, role').where( voided: false )
      users
    end

    def self.edit_user(user_id:, national_id:, username:, firstname:, lastname:, email:, role:)
      User.transaction do 
        person_id = User.where(id: user_id).pluck(:person_id);
        User.where(id: user_id).update_all(
                                username: username,
                                email: email, 
                                role: role)
        
        Person.transaction do
          Person.where(id: person_id).update_all(
                                national_id: national_id,
                                firstname: firstname, 
                                lastname: lastname
                                )
        end
        
      end
    end

    def self.delete_user(user_id:)
      User.where(id: user_id).update_all(voided: true)
    end

    def self.update_profile(user_id:, new_password:)
      user = User.find_by(id: user_id, voided: false)
      if user
        user.update(password: new_password)
      end
    end

    def self.generate_random_password(length =  8)
      characters = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
      password = ''

      length.times do 
        password += characters.sample.to_s
      end

      password
    end

end