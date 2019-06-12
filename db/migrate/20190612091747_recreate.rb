
class Recreate < ActiveRecord::Migration[5.2]
  def change
    add_column :users,:name, null: false
    add_column :users,:uid
    add_column :users,:provider
    add_column :users,:nickname
    add_column :users,:location
    add_column :users,:image
  end
end
