class Post < ApplicationRecord
  belongs_to :user
  generate_public_uid

  def to_param
    public_uid
  end
end
