class Subscription < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :event

  validate :user_owner
  validate :existing_user, unless: -> { user.present? }

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }

  # Для конкретного event_id один юзер может подписаться только один раз (если юзер задан)
  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }

  # Или один email может использоваться только один раз (если анонимная подписка)
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def user_owner
    errors.add(:user_name, :user_owner_event) if user == event.user
  end

  def existing_user
    errors.add(:user_email, :user_owner_email) if User.find_by(email: user_email)
  end
end
