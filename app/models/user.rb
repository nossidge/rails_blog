class User < ApplicationRecord
  has_many :posts

  has_secure_password

  validates :name, presence: true
  validates :password, length: { minimum: 8 }

  # ToDo: Send mail with confirmation link.
  validates_format_of :email, :with => /@/, :message => "must contain an @ sign"
end
