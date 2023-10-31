class AddImageToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :image, :string
  end
end
