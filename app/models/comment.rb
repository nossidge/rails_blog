class Comment < ApplicationRecord
  belongs_to :post

  validates :name, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 500 }
end
