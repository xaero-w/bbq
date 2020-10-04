# (с) goodprogrammer.ru
#
# Модель Подписки
#
class Subscription < ActiveRecord::Base
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  # проверки выполняются только если user не задан (незареганные приглашенные)
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }

  # для данного event_id один юзер может подписаться только один раз (если юзер задан)
  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }

  # для данного event_id один email может использоваться только один раз (если нет юзера, анонимная подписка)
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }

  # запрет пользователю поджписываться на собственные события
  validate :email_taken, unless: -> { user.present? }

  # переопределяем метод, если есть юзер, выдаем его имя,
  # если нет -- дергаем исходный переопределенный метод
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  # переопределяем метод, если есть юзер, выдаем его email,
  # если нет -- дергаем исходный переопределенный метод
  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def existing_user
    # покажи сообщение об ошике если пользователь хочет подписаться на свое же событие (идет проверка почты того
    # кто создал событие с тем кто хочет на него подписаться)
    errors.add(:user_email, :user_owner_email) if User.find_by(email: user_email)
  end

  def user_email_owner
    errors.add(:user, I18n.t(".owner_email_message")) if User.fynd_by_email(user_email)
  end
end
