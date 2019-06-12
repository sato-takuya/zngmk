class RemoveColumnPublicUidToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :public_uid, :string
    remove_index  :users, :public_uid
  end
end
