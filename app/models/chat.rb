class Chat < ApplicationRecord

  belongs_to :customer
  belongs_to :room
  has_many :notices, dependent: :destroy

  validates :message, length: { in: 1..140 }


end
