class PersonCustodianMapping < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :response_actions, :intrusions,
    column: :intrusion_id, primary_key: :id   
  end
end
