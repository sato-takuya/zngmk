class RemoveAccountidFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :accountid, :string
  end
end
