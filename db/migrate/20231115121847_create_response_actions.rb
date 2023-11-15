class CreateResponseActions < ActiveRecord::Migration[7.1]
  def change
    create_table :response_actions do |t|
      t.bigint :intrusion_id
      t.string :action_type
      t.text   :description
      t.timestamps
    end
  end
end
