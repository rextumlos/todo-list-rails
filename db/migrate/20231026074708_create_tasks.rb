class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :activity
      t.references :user
      t.datetime :completed_at, default: nil
      t.datetime :cancelled_at, default: nil
      t.string :state
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end
