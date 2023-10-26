class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :user
      t.datetime :completed_at, default: nil
      t.datetime :cancelled_at, default: nil
      t.string :state
      t.string :title, null: false
      t.text :description
      t.timestamps
    end
  end
end
