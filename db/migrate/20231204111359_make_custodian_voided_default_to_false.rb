class MakeCustodianVoidedDefaultToFalse < ActiveRecord::Migration[7.1]
  def change
    change_column :custodians, :voided, :boolean, default: false, null: false
  end
end
