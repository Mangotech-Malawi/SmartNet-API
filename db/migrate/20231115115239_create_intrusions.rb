class CreateIntrusions < ActiveRecord::Migration[7.1]
  def change
    create_table :intrusions do |t|
      t.bigint  :network_event_id
      t.text    :description
      t.boolean :voided
      t.timestamps
    end

    add_foreign_key :intrusions, :network_events,
    column: :network_event_id, primary_key: :id   
  end
end
