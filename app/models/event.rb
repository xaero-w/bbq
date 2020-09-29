class Event < ApplicationRecord
  # событие принадлежит юзеру
  belongs_to :user

  has_many :comments

  validates :user, presence: true

  validates :title, presence: true, length: {maximum: 255}
  validates :address, presence: true
  validates :datetime, presence: true
end
