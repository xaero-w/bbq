class Event < ApplicationRecord
  # событие принадлежит юзеру
  belongs_to :user

  has_many :comments
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos

  # юзера не может не быть
  validates :user, presence: true

  # заголовок должен быть и не длинее 255 букв
  validates :title, presence: true, length: {maximum: 255}

  validates :address, presence: true
  validates :datetime, presence: true

  def visitors
    (subscriptions + [user]).uniq
  end
end
