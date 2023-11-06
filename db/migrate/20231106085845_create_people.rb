class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.string :gender
      t.string :date_of_birth
      t.string :national_id
      t.string :phone_number
      t.string :alt_phone_number
      t.timestamps
    end
  end
end
