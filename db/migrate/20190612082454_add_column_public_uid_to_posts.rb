class AddColumnPublicUidToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :public_uid, :string
    add_index  :posts, :public_uid, unique: true
  end
end
