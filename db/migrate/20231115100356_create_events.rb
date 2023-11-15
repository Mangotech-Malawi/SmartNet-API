class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string  :name
      t.string  :description
      t.string  :severity
      t.boolean :voided
      t.timestamps
    end

    add_column :network_events, :event_id, :bigint
    
    add_foreign_key :network_events, :events,
    column: :event_id, primary_key: :id    
  end
end
