class CreateTaskTagShips < ActiveRecord::Migration[7.0]
  def change
    create_table :task_tag_ships do |t|
      t.references :task
      t.references :tag
      t.timestamps
    end
  end
end
