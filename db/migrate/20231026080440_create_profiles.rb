class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user
      t.date :birthday
      t.string :display_name
      t.string :location
      t.text :bio
      t.timestamps
    end
  end
end
