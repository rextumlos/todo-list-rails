class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.references :activity
      t.string :name
      t.timestamps
    end
  end
end
