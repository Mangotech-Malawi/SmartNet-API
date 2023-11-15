class CreateDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :departments do |t|
      t.string    :name
      t.text      :description
      t.string    :phone_number
      t.string    :email
      t.boolean   :voided
      t.timestamps
    end
  end
end
