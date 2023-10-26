class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.references :user
      t.references :activity
      t.timestamps
    end
  end
end
