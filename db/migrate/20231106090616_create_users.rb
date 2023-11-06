class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.bigint  :person_id
      t.string  :name
      t.string  :username
      t.string  :email
      t.string  :password_digest
      t.string  :role
      t.boolean :voided, default: false
      t.timestamps
    end

    add_foreign_key :users, :people,
    column: :person_id, primary_key: :id
  end
end
