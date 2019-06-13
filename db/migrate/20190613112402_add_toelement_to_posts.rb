class AddToelementToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :to_element, :boolean, default: true, null: false
  end
end
