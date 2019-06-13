class Post < ApplicationRecord
  belongs_to :user
  validates :content,presence: true,length:{maximum: 50}
  generate_public_uid

  def to_param
    public_uid
  end
end
