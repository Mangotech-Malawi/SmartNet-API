class CreateCustodians < ActiveRecord::Migration[7.1]
  def change
    create_table :custodians do |t|
      t.bigint  :custodian_type_id
      t.string  :custodian_type
      t.boolean :voided
      t.timestamps
    end

    remove_foreign_key :devices, column: :person_id

    remove_column :devices, :person_id

    add_column :devices, :custodian_id, :bigint

    add_foreign_key :devices, :custodians,
    column: :custodian_id, primary_key: :id   
  end
end
