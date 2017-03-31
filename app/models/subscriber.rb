class Subscriber < ApplicationRecord

  validates :name, presence: true

  # ToDo: Send mail with confirmation link.
  validates_format_of :email, :with => /@/, :message => "must contain an @ sign"
end
