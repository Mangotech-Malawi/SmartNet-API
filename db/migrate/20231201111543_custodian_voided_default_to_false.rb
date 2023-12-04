class CustodianVoidedDefaultToFalse < ActiveRecord::Migration[7.1]
  def change
    change_column :intrusions, :voided, :boolean, default: false, null: false
    change_column :devices, :voided, :boolean, default: false, null: false
    change_column :network_events, :voided, :boolean, default: false, null: false
    change_column :events, :voided, :boolean, default: false, null: false
    add_column :response_actions, :voided, :boolean, default: false, null: false
    change_column :departments, :voided, :boolean, default: false, null: false
  end
end
