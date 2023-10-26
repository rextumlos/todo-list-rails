class CreateAssignedMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :assigned_members do |t|
      t.references :user
      t.references :task
      t.timestamps
    end
  end
end
