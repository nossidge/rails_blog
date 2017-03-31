class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: { maximum: 140 }
  validates :body, presence: true

  def to_param
    [id, title.parameterize].join("-")
  end
end
